import SwiftUI
import Charts

struct StatsView: View {
    @Environment(StudyStore.self) private var store
    @State private var confirmReset = false

    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack {
                        StatTile(value: "\(store.totalAnswered)", label: "解いた数")
                        StatTile(value: store.accuracyText, label: "正答率")
                        StatTile(value: "\(store.streak)日", label: "連続学習")
                    }
                    .padding(.vertical, 6)
                }

                Section("直近14日") {
                    Chart(store.last14Days) { d in
                        BarMark(
                            x: .value("日", d.date, unit: .day),
                            y: .value("問題数", d.count)
                        )
                        .foregroundStyle(Theme.accent)
                        .cornerRadius(4)
                    }
                    .frame(height: 160)
                    .padding(.vertical, 8)
                }

                Section("科目別の正答率") {
                    ForEach(Subject.allCases) { s in
                        subjectRow(s)
                    }
                }

                Section("論点の習得") {
                    HStack {
                        Text("全問正解した論点")
                        Spacer()
                        Text("\(store.masteredTopics) / \(store.topics.count)")
                            .monospacedDigit()
                            .foregroundStyle(.secondary)
                    }
                }

                Section {
                    Button("学習記録をリセット", role: .destructive) { confirmReset = true }
                }
            }
            .navigationTitle("記録")
            .confirmationDialog("学習記録をすべて消去しますか？", isPresented: $confirmReset, titleVisibility: .visible) {
                Button("消去する", role: .destructive) { store.reset() }
            }
        }
    }

    @ViewBuilder
    private func subjectRow(_ s: Subject) -> some View {
        let st = store.subjectStats(s)
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                SubjectTag(subject: s)
                Spacer()
                Text(st.answered == 0 ? "未着手" : "\(Int((Double(st.correct) / Double(st.answered) * 100).rounded()))%（\(st.correct)/\(st.answered)）")
                    .font(.caption)
                    .monospacedDigit()
                    .foregroundStyle(.secondary)
            }
            ProgressView(value: st.answered == 0 ? 0 : Double(st.correct) / Double(st.answered))
                .tint(s.color)
        }
        .padding(.vertical, 4)
    }
}
