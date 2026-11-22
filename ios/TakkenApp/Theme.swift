import SwiftUI

enum Theme {
    static let accent = Color(red: 0.06, green: 0.47, blue: 0.42)
    static let gradient = LinearGradient(
        colors: [Color(red: 0.11, green: 0.58, blue: 0.50), Color(red: 0.03, green: 0.30, blue: 0.33)],
        startPoint: .topLeading, endPoint: .bottomTrailing)
    static let background = Color(uiColor: .systemGroupedBackground)
    static let card = Color(uiColor: .secondarySystemGroupedBackground)
    static let good = Color(red: 0.13, green: 0.62, blue: 0.38)
    static let bad = Color(red: 0.86, green: 0.27, blue: 0.27)
}

extension Subject {
    var color: Color {
        switch self {
        case .gyoho: Color(red: 0.17, green: 0.43, blue: 0.85)
        case .kenri: Color(red: 0.55, green: 0.33, blue: 0.80)
        case .horei: Color(red: 0.88, green: 0.50, blue: 0.13)
        case .zei: Color(red: 0.18, green: 0.60, blue: 0.53)
        }
    }

    var symbol: String {
        switch self {
        case .gyoho: "building.2"
        case .kenri: "scale.3d"
        case .horei: "map"
        case .zei: "yensign.circle"
        }
    }
}

extension Grade {
    var color: Color {
        switch self {
        case .s: Color(red: 0.86, green: 0.27, blue: 0.27)
        case .a: Color(red: 0.92, green: 0.55, blue: 0.13)
        case .b: Color(red: 0.17, green: 0.43, blue: 0.85)
        case .c: Color.gray
        }
    }
}

struct CardBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Theme.card, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
    }
}

extension View {
    func card() -> some View { modifier(CardBackground()) }
}

struct GradeBadge: View {
    let grade: Grade
    var body: some View {
        Text(grade.rawValue)
            .font(.system(.caption, design: .rounded).weight(.heavy))
            .foregroundStyle(.white)
            .frame(width: 24, height: 24)
            .background(grade.color, in: RoundedRectangle(cornerRadius: 7, style: .continuous))
    }
}

struct SubjectTag: View {
    let subject: Subject
    var body: some View {
        Label(subject.rawValue, systemImage: subject.symbol)
            .font(.caption2.weight(.semibold))
            .foregroundStyle(subject.color)
    }
}

struct SourceBadge: View {
    let question: Question
    var body: some View {
        HStack(spacing: 8) {
            if let s = question.source {
                Label(s.label, systemImage: "calendar")
            } else {
                Label("オリジナル問題", systemImage: "sparkles")
            }
            if let sim = question.similar, !sim.isEmpty {
                Text("類題 " + sim.map(\.shortEra).joined(separator: "・"))
            }
        }
        .font(.caption.weight(.medium))
        .foregroundStyle(.secondary)
    }
}

struct StatTile: View {
    let value: String
    let label: String
    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.system(.title2, design: .rounded).weight(.bold))
                .monospacedDigit()
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
}

struct TopicRow: View {
    @Environment(StudyStore.self) private var store
    let topic: Topic

    var body: some View {
        HStack(spacing: 12) {
            Text("\(store.rank(of: topic))")
                .font(.system(.title3, design: .rounded).weight(.bold))
                .monospacedDigit()
                .foregroundStyle(Theme.accent)
                .frame(width: 32)
            VStack(alignment: .leading, spacing: 4) {
                Text(topic.title)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.primary)
                HStack(spacing: 8) {
                    SubjectTag(subject: topic.subject)
                    Text("約\(topic.estimatedCount)問/10年")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
                ProgressView(value: store.mastery(of: topic))
                    .tint(topic.subject.color)
            }
            GradeBadge(grade: topic.grade)
        }
        .padding(.vertical, 4)
    }
}

struct QuestionRow: View {
    @Environment(StudyStore.self) private var store
    let question: Question

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            statusIcon
            VStack(alignment: .leading, spacing: 4) {
                Text(question.text)
                    .font(.subheadline)
                    .lineLimit(2)
                SourceBadge(question: question)
            }
        }
        .card()
    }

    @ViewBuilder private var statusIcon: some View {
        switch store.status(of: question) {
        case .some(true):
            Image(systemName: "checkmark.circle.fill").foregroundStyle(Theme.good)
        case .some(false):
            Image(systemName: "xmark.circle.fill").foregroundStyle(Theme.bad)
        case .none:
            Image(systemName: "circle").foregroundStyle(.tertiary)
        }
    }
}
