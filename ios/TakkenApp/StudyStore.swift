import Foundation
import Observation

struct QRecord: Codable {
    var attempts = 0
    var correct = 0
    var lastCorrect = false
    var lastAt: Date? = nil
    var due: Date? = nil
    /// 次の復習までの間隔（日）
    var interval: Double = 0
}

struct DayLog: Codable {
    var answered = 0
    var correct = 0
}

struct DayPoint: Identifiable {
    let date: Date
    let count: Int
    var id: Date { date }
}

private struct SaveData: Codable {
    var records: [String: QRecord]
    var daily: [String: DayLog]
}

@Observable
final class StudyStore {
    let topics: [Topic]
    let questions: [Question]
    /// 出る順に並べた論点
    let rankedTopics: [Topic]
    /// 出る順に並べた問題（論点の出る順 → 類題の出題年数の多い順）
    let rankedQuestions: [Question]
    private let topicByID: [String: Topic]
    private let rankByTopic: [String: Int]

    var records: [String: QRecord] = [:]
    var daily: [String: DayLog] = [:]

    init() {
        let t: [Topic] = StudyStore.loadJSON("topics")
        let q: [Question] = StudyStore.loadJSON("questions")
        topics = t
        questions = q

        let sortedTopics = t.sorted { a, b in
            if a.estimatedCount != b.estimatedCount { return a.estimatedCount > b.estimatedCount }
            if a.subject.order != b.subject.order { return a.subject.order < b.subject.order }
            return a.id < b.id
        }
        rankedTopics = sortedTopics

        var rank: [String: Int] = [:]
        for (i, topic) in sortedTopics.enumerated() { rank[topic.id] = i + 1 }
        rankByTopic = rank
        topicByID = Dictionary(t.map { ($0.id, $0) }, uniquingKeysWith: { a, _ in a })

        rankedQuestions = q.sorted { a, b in
            let ra = rank[a.topicId] ?? Int.max
            let rb = rank[b.topicId] ?? Int.max
            if ra != rb { return ra < rb }
            let ya = a.askedYears.count, yb = b.askedYears.count
            if ya != yb { return ya > yb }
            return a.id < b.id
        }

        loadProgress()
    }

    // MARK: - 参照

    func topic(for q: Question) -> Topic? { topicByID[q.topicId] }

    func rank(of topic: Topic) -> Int { rankByTopic[topic.id] ?? 0 }

    func questions(for topic: Topic) -> [Question] {
        rankedQuestions.filter { $0.topicId == topic.id }
    }

    func questions(subject: Subject) -> [Question] {
        rankedQuestions.filter { topicByID[$0.topicId]?.subject == subject }
    }

    func questions(year: Int) -> [Question] {
        rankedQuestions
            .filter { $0.source?.year == year }
            .sorted { ($0.source?.number ?? 0, $0.source?.choice ?? 0) < ($1.source?.number ?? 0, $1.source?.choice ?? 0) }
    }

    func questions(kind: QuestionKind) -> [Question] {
        rankedQuestions.filter { $0.kind == kind }
    }

    /// 過去問データがある年度（新しい順）
    var pastYears: [Int] {
        Array(Set(questions.compactMap { $0.source?.year })).sorted(by: >)
    }

    // MARK: - 出題

    /// 復習が必要な問題（間違えた問題・復習期限が来た問題）
    var reviewQueue: [Question] {
        let now = Date()
        return rankedQuestions.filter { q in
            guard let r = records[q.id] else { return false }
            if !r.lastCorrect { return true }
            if let due = r.due { return due <= now }
            return false
        }
    }

    /// 出る順で次に解くべき問題：未回答・間違い・復習期限の来た問題を出る順に
    func nextSet(_ count: Int) -> [Question] {
        let now = Date()
        let pending = rankedQuestions.filter { q in
            guard let r = records[q.id] else { return true }
            if !r.lastCorrect { return true }
            if let due = r.due { return due <= now }
            return false
        }
        let pick = pending.isEmpty ? rankedQuestions : pending
        return Array(pick.prefix(count))
    }

    func status(of q: Question) -> Bool? {
        guard let r = records[q.id] else { return nil }
        return r.lastCorrect
    }

    /// 論点の習得度（最後に正解した問題の割合）
    func mastery(of topic: Topic) -> Double {
        let qs = questions(for: topic)
        guard !qs.isEmpty else { return 0 }
        let ok = qs.filter { records[$0.id]?.lastCorrect == true }.count
        return Double(ok) / Double(qs.count)
    }

    // MARK: - 記録

    func record(_ q: Question, correct: Bool) {
        var r = records[q.id] ?? QRecord()
        r.attempts += 1
        if correct {
            r.correct += 1
            r.interval = r.interval < 1 ? 1 : min(r.interval * 2.5, 60)
        } else {
            r.interval = 0
        }
        r.lastCorrect = correct
        r.lastAt = Date()
        r.due = Calendar.current.date(byAdding: .minute, value: Int(r.interval * 24 * 60), to: Date())
        records[q.id] = r

        let key = StudyStore.dayKey(Date())
        var d = daily[key] ?? DayLog()
        d.answered += 1
        if correct { d.correct += 1 }
        daily[key] = d
        save()
    }

    func reset() {
        records = [:]
        daily = [:]
        save()
    }

    var totalAnswered: Int { daily.values.reduce(0) { $0 + $1.answered } }
    var totalCorrect: Int { daily.values.reduce(0) { $0 + $1.correct } }
    var todayAnswered: Int { daily[StudyStore.dayKey(Date())]?.answered ?? 0 }

    var accuracyText: String {
        guard totalAnswered > 0 else { return "–" }
        return "\(Int((Double(totalCorrect) / Double(totalAnswered) * 100).rounded()))%"
    }

    /// 連続学習日数（今日まだなら昨日から数える）
    var streak: Int {
        let cal = Calendar.current
        var day = Date()
        if (daily[StudyStore.dayKey(day)]?.answered ?? 0) == 0 {
            day = cal.date(byAdding: .day, value: -1, to: day)!
        }
        var n = 0
        while (daily[StudyStore.dayKey(day)]?.answered ?? 0) > 0 {
            n += 1
            day = cal.date(byAdding: .day, value: -1, to: day)!
        }
        return n
    }

    var last14Days: [DayPoint] {
        let cal = Calendar.current
        let today = cal.startOfDay(for: Date())
        return (0..<14).reversed().map { offset in
            let d = cal.date(byAdding: .day, value: -offset, to: today)!
            return DayPoint(date: d, count: daily[StudyStore.dayKey(d)]?.answered ?? 0)
        }
    }

    func subjectStats(_ s: Subject) -> (answered: Int, correct: Int) {
        var a = 0, c = 0
        for q in questions(subject: s) {
            if let r = records[q.id] {
                a += r.attempts
                c += r.correct
            }
        }
        return (a, c)
    }

    var masteredTopics: Int {
        topics.filter { mastery(of: $0) >= 0.999 }.count
    }

    // MARK: - 保存

    private static var saveURL: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("progress.json")
    }

    private func save() {
        let data = SaveData(records: records, daily: daily)
        if let d = try? JSONEncoder().encode(data) {
            try? d.write(to: StudyStore.saveURL, options: .atomic)
        }
    }

    private func loadProgress() {
        guard let d = try? Data(contentsOf: StudyStore.saveURL),
              let s = try? JSONDecoder().decode(SaveData.self, from: d) else { return }
        records = s.records
        daily = s.daily
    }

    private static func dayKey(_ date: Date) -> String {
        let c = Calendar.current.dateComponents([.year, .month, .day], from: date)
        return String(format: "%04d-%02d-%02d", c.year ?? 0, c.month ?? 0, c.day ?? 0)
    }

    private static func loadJSON<T: Decodable>(_ name: String) -> [T] {
        guard let url = Bundle.main.url(forResource: name, withExtension: "json"),
              let data = try? Data(contentsOf: url) else { return [] }
        do {
            return try JSONDecoder().decode([T].self, from: data)
        } catch {
            print("\(name).json の読み込みに失敗: \(error)")
            return []
        }
    }
}
