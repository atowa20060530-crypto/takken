import SwiftUI
import UIKit

struct QuizView: View {
    @Environment(StudyStore.self) private var store
    @Environment(\.dismiss) private var dismiss
    @Environment(\.openURL) private var openURL

    private let title: String
    @State private var items: [Question]
    @State private var index = 0
    @State private var picked: Int?
    @State private var results: [String: Bool] = [:]
    @State private var finished = false
    @State private var showPoints = false

    init(session: QuizSession) {
        title = session.title
        _items = State(initialValue: session.questions)
    }

    var body: some View {
        NavigationStack {
            Group {
                if finished || items.isEmpty {
                    resultView
                } else {
                    questionView(items[index])
                }
            }
            .background(Theme.background)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button { dismiss() } label: {
                        Image(systemName: "xmark").font(.body.weight(.semibold))
                    }
                }
                ToolbarItem(placement: .principal) {
                    if !finished && !items.isEmpty {
                        Text("\(index + 1) / \(items.count)")
                            .font(.subheadline.weight(.semibold))
                            .monospacedDigit()
                    } else {
                        Text(title).font(.subheadline.weight(.semibold))
                    }
                }
            }
        }
    }

    // MARK: - 問題

    @ViewBuilder
    private func questionView(_ q: Question) -> some View {
        let topic = store.topic(for: q)
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                ProgressView(value: Double(index), total: Double(max(items.count, 1)))
                    .tint(Theme.accent)
                if let t = topic {
                    HStack(spacing: 8) {
                        GradeBadge(grade: t.grade)
                        Text("出る順 \(store.rank(of: t))位 · \(t.title)")
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(.secondary)
                            .lineLimit(1)
                    }
                }
                SourceBadge(question: q)
                Text(q.text)
                    .font(.title3.weight(.medium))
                    .lineSpacing(5)
                    .fixedSize(horizontal: false, vertical: true)
                optionsView(q)
                if picked != nil {
                    explanationView(q, topic: topic)
                }
            }
            .padding(16)
        }
        .id(q.id)
        .safeAreaInset(edge: .bottom) {
            if picked != nil {
                Button(action: next) {
                    Text(index + 1 < items.count ? "次へ" : "結果を見る")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Theme.accent, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                        .foregroundStyle(.white)
                }
                .buttonStyle(.plain)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(.bar)
            }
        }
    }

    @ViewBuilder
    private func optionsView(_ q: Question) -> some View {
        if q.kind == .tf {
            HStack(spacing: 12) {
                ForEach(0..<2, id: \.self) { i in
                    Button { answer(q, i) } label: {
                        VStack(spacing: 2) {
                            Text(i == 0 ? "○" : "×")
                                .font(.system(size: 44, weight: .bold, design: .rounded))
                            Text(i == 0 ? "正しい" : "誤り")
                                .font(.caption.weight(.semibold))
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 18)
                        .foregroundStyle(foreground(q, i))
                        .background(fill(q, i), in: RoundedRectangle(cornerRadius: 18, style: .continuous))
                        .overlay(
                            RoundedRectangle(cornerRadius: 18, style: .continuous)
                                .stroke(border(q, i), lineWidth: 2)
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
        } else {
            VStack(spacing: 10) {
                ForEach(Array(q.options.enumerated()), id: \.offset) { i, opt in
                    Button { answer(q, i) } label: {
                        HStack(alignment: .top, spacing: 12) {
                            Text("\(i + 1)")
                                .font(.system(.subheadline, design: .rounded).weight(.bold))
                                .frame(width: 26, height: 26)
                                .background(Circle().fill(border(q, i).opacity(0.25)))
                            Text(opt)
                                .multilineTextAlignment(.leading)
                                .fixedSize(horizontal: false, vertical: true)
                            Spacer(minLength: 0)
                            if picked != nil && i == q.correctIndex {
                                Image(systemName: "checkmark.circle.fill").foregroundStyle(Theme.good)
                            }
                        }
                        .padding(14)
                        .foregroundStyle(foreground(q, i))
                        .background(fill(q, i), in: RoundedRectangle(cornerRadius: 14, style: .continuous))
                        .overlay(
                            RoundedRectangle(cornerRadius: 14, style: .continuous)
                                .stroke(border(q, i), lineWidth: 1.5)
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }

    @ViewBuilder
    private func explanationView(_ q: Question, topic: Topic?) -> some View {
        let ok = picked == q.correctIndex
        VStack(alignment: .leading, spacing: 10) {
            Label(ok ? "正解" : "不正解", systemImage: ok ? "checkmark.circle.fill" : "xmark.circle.fill")
                .font(.headline)
                .foregroundStyle(ok ? Theme.good : Theme.bad)
            if q.kind == .tf {
                Text("答え：" + (q.answer == true ? "○ 正しい" : "× 誤り"))
                    .font(.subheadline.weight(.semibold))
            } else {
                Text("答え：\(q.correctIndex + 1)")
                    .font(.subheadline.weight(.semibold))
            }
            Text(q.explanation)
                .font(.callout)
                .fixedSize(horizontal: false, vertical: true)
            if let t = topic {
                Divider()
                DisclosureGroup(isExpanded: $showPoints) {
                    VStack(alignment: .leading, spacing: 6) {
                        ForEach(t.points, id: \.self) { p in
                            Text("・" + p)
                                .font(.callout)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 6)
                } label: {
                    Text("論点の要点：\(t.title)")
                        .font(.subheadline.weight(.semibold))
                }
                Button {
                    openURL(t.youtubeURL)
                } label: {
                    Label("YouTubeで解説を見る", systemImage: "play.rectangle.fill")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.red)
                }
                .buttonStyle(.plain)
            }
        }
        .card()
    }

    private func fill(_ q: Question, _ i: Int) -> Color {
        guard let p = picked else { return Theme.card }
        if i == q.correctIndex { return Theme.good.opacity(0.15) }
        if i == p { return Theme.bad.opacity(0.12) }
        return Theme.card
    }

    private func foreground(_ q: Question, _ i: Int) -> Color {
        guard let p = picked else { return .primary }
        if i == q.correctIndex { return Theme.good }
        if i == p { return Theme.bad }
        return .secondary
    }

    private func border(_ q: Question, _ i: Int) -> Color {
        guard let p = picked else { return Color.secondary.opacity(0.2) }
        if i == q.correctIndex { return Theme.good }
        if i == p { return Theme.bad }
        return Color.secondary.opacity(0.2)
    }

    private func answer(_ q: Question, _ i: Int) {
        guard picked == nil else { return }
        picked = i
        let ok = i == q.correctIndex
        results[q.id] = ok
        store.record(q, correct: ok)
        UINotificationFeedbackGenerator().notificationOccurred(ok ? .success : .error)
    }

    private func next() {
        if index + 1 < items.count {
            index += 1
            picked = nil
            showPoints = false
        } else {
            finished = true
        }
    }

    // MARK: - 結果

    @ViewBuilder
    private var resultView: some View {
        let correct = items.filter { results[$0.id] == true }.count
        let wrong = items.filter { results[$0.id] == false }
        VStack(spacing: 24) {
            Spacer()
            if items.isEmpty {
                Image(systemName: "checkmark.seal.fill")
                    .font(.system(size: 64))
                    .foregroundStyle(Theme.accent)
                Text("いま解く問題はありません")
                    .font(.headline)
            } else {
                ZStack {
                    Circle().stroke(Theme.accent.opacity(0.15), lineWidth: 14)
                    Circle()
                        .trim(from: 0, to: CGFloat(correct) / CGFloat(items.count))
                        .stroke(Theme.accent, style: StrokeStyle(lineWidth: 14, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                    VStack(spacing: 2) {
                        Text("\(correct)/\(items.count)")
                            .font(.system(size: 40, weight: .bold, design: .rounded))
                            .monospacedDigit()
                        Text("正解").font(.subheadline).foregroundStyle(.secondary)
                    }
                }
                .frame(width: 180, height: 180)
                Text(message(correct: correct, total: items.count))
                    .font(.headline)
                    .multilineTextAlignment(.center)
            }
            Spacer()
            VStack(spacing: 12) {
                if !wrong.isEmpty {
                    Button {
                        restart(with: wrong)
                    } label: {
                        Text("間違えた\(wrong.count)問を解き直す")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Theme.accent, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .foregroundStyle(.white)
                    }
                }
                Button {
                    dismiss()
                } label: {
                    Text("終わる")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Theme.card, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                        .foregroundStyle(Theme.accent)
                }
            }
            .buttonStyle(.plain)
            .padding(16)
        }
        .frame(maxWidth: .infinity)
    }

    private func message(correct: Int, total: Int) -> String {
        let rate = Double(correct) / Double(max(total, 1))
        switch rate {
        case 1: return "全問正解！この調子"
        case 0.7...: return "合格ライン。間違いだけ見直そう"
        case 0.4...: return "あと一歩。要点と動画で確認しよう"
        default: return "まずは要点を読んでから再挑戦"
        }
    }

    private func restart(with qs: [Question]) {
        items = qs
        index = 0
        picked = nil
        results = [:]
        finished = false
        showPoints = false
    }
}
