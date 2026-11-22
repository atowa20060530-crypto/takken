import Foundation

/// 試験の4科目
enum Subject: String, Codable, CaseIterable, Identifiable {
    case gyoho = "宅建業法"
    case kenri = "権利関係"
    case horei = "法令上の制限"
    case zei = "税・その他"

    var id: String { rawValue }

    var shortName: String {
        switch self {
        case .gyoho: "業法"
        case .kenri: "権利"
        case .horei: "法令"
        case .zei: "税他"
        }
    }

    /// 本試験での出題数（50問中）
    var examQuestions: Int {
        switch self {
        case .gyoho: 20
        case .kenri: 14
        case .horei: 8
        case .zei: 8
        }
    }

    var order: Int {
        switch self {
        case .gyoho: 0
        case .kenri: 1
        case .horei: 2
        case .zei: 3
        }
    }
}

/// 出る順ランク（類題を含めた過去10年の出題数で決まる）
enum Grade: String {
    case s = "S", a = "A", b = "B", c = "C"

    init(count: Int) {
        switch count {
        case 20...: self = .s
        case 10..<20: self = .a
        case 6..<10: self = .b
        default: self = .c
        }
    }

    var caption: String {
        switch self {
        case .s: "毎年複数問"
        case .a: "ほぼ毎年"
        case .b: "よく出る"
        case .c: "ときどき"
        }
    }
}

/// 過去問の出典（例：令和5年度 問3（肢2））
struct PastExam: Codable, Hashable {
    /// 西暦の試験年度
    let year: Int
    /// 問番号
    let number: Int
    /// 肢番号（一問一答に分解した場合）
    let choice: Int?

    var eraLabel: String { PastExam.wareki(year) }

    var label: String {
        var s = "\(eraLabel) 問\(number)"
        if let c = choice { s += "（肢\(c)）" }
        return s
    }

    var shortEra: String { year >= 2019 ? "R\(year - 2018)" : "H\(year - 1988)" }

    static func wareki(_ y: Int) -> String {
        if y >= 2019 {
            let n = y - 2018
            return n == 1 ? "令和元年度" : "令和\(n)年度"
        }
        return "平成\(y - 1988)年度"
    }
}

/// 論点（インプットの単位）
struct Topic: Codable, Identifiable, Hashable {
    let id: String
    let subject: Subject
    let title: String
    let summary: String
    let points: [String]
    /// 類題を含めた過去10年の出題数（目安）。過去問データ取込後は実数に置き換える
    let estimatedCount: Int
    /// YouTube検索に使う語句
    let videoQuery: String
    /// 特定の動画URL（再生開始位置 &t=120 なども可）。あればこちらを優先
    let videoURL: String?

    var grade: Grade { Grade(count: estimatedCount) }

    var youtubeURL: URL {
        if let s = videoURL, let u = URL(string: s) { return u }
        var c = URLComponents(string: "https://www.youtube.com/results")!
        c.queryItems = [URLQueryItem(name: "search_query", value: videoQuery)]
        return c.url!
    }
}

enum QuestionKind: String, Codable {
    /// 一問一答（○×）
    case tf
    /// 四肢択一
    case mc
}

/// 問題（アウトプットの単位）
struct Question: Codable, Identifiable, Hashable {
    let id: String
    let topicId: String
    let kind: QuestionKind
    let text: String
    /// 一問一答の正解（true = ○）
    let answer: Bool?
    /// 四肢択一の選択肢
    let choices: [String]?
    /// 四肢択一の正解（0始まり）
    let answerIndex: Int?
    let explanation: String
    /// 過去問の出典。nil ならオリジナル問題
    let source: PastExam?
    /// 同じ論点・同じ知識を問う類題の出題歴
    let similar: [PastExam]?

    var options: [String] { kind == .tf ? ["○", "×"] : (choices ?? []) }

    var correctIndex: Int {
        kind == .tf ? ((answer ?? true) ? 0 : 1) : (answerIndex ?? 0)
    }

    /// 類題を含めて出題された年度
    var askedYears: Set<Int> {
        var s = Set((similar ?? []).map(\.year))
        if let y = source?.year { s.insert(y) }
        return s
    }
}

struct QuizSession: Identifiable {
    let id = UUID()
    let title: String
    let questions: [Question]
}
