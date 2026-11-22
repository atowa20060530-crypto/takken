import SwiftUI

struct PracticeView: View {
    @Environment(StudyStore.self) private var store
    @State private var session: QuizSession?

    var body: some View {
        NavigationStack {
            List {
                Section("おすすめ") {
                    launcher("出る順で10問", icon: "flame.fill",
                             detail: "未回答・間違えた問題を出る順に") { store.nextSet(10) }
                    launcher("復習", icon: "arrow.counterclockwise",
                             detail: "\(store.reviewQueue.count)問") { store.reviewQueue }
                    launcher("ランダム10問", icon: "shuffle",
                             detail: "全\(store.questions.count)問から") { Array(store.questions.shuffled().prefix(10)) }
                }

                Section("科目別（出る順）") {
                    ForEach(Subject.allCases) { s in
                        launcher(s.rawValue, icon: s.symbol, tint: s.color,
                                 detail: "\(store.questions(subject: s).count)問 · 本試験\(s.examQuestions)問") {
                            store.questions(subject: s)
                        }
                    }
                }

                Section {
                    if store.pastYears.isEmpty {
                        Text("過去問データを取り込むと、年度ごとに解けるようになります。")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    } else {
                        ForEach(store.pastYears, id: \.self) { y in
                            launcher(PastExam.wareki(y), icon: "calendar",
                                     detail: "\(store.questions(year: y).count)問") { store.questions(year: y) }
                        }
                    }
                } header: {
                    Text("年度別（過去問）")
                }

                Section("形式") {
                    launcher("一問一答（○×）", icon: "circle.circle",
                             detail: "\(store.questions(kind: .tf).count)問") { store.questions(kind: .tf) }
                    launcher("四肢択一", icon: "list.bullet.rectangle",
                             detail: "\(store.questions(kind: .mc).count)問") { store.questions(kind: .mc) }
                }
            }
            .navigationTitle("問題")
            .fullScreenCover(item: $session) { QuizView(session: $0).environment(store) }
        }
    }

    private func launcher(_ title: String, icon: String, tint: Color = Theme.accent,
                          detail: String, make: @escaping () -> [Question]) -> some View {
        Button {
            let qs = make()
            if !qs.isEmpty { session = QuizSession(title: title, questions: qs) }
        } label: {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .foregroundStyle(tint)
                    .frame(width: 28)
                VStack(alignment: .leading, spacing: 2) {
                    Text(title).foregroundStyle(.primary)
                    Text(detail).font(.caption).foregroundStyle(.secondary)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundStyle(.tertiary)
            }
        }
    }
}
