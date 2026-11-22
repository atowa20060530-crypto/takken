import SwiftUI

struct HomeView: View {
    @Environment(StudyStore.self) private var store
    @State private var session: QuizSession?

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    todayCard
                    startCard
                    if !store.reviewQueue.isEmpty { reviewCard }
                    topSection
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 24)
            }
            .background(Theme.background)
            .navigationTitle("宅建 出る順")
            .navigationDestination(for: Topic.self) { TopicDetailView(topic: $0) }
            .fullScreenCover(item: $session) { QuizView(session: $0).environment(store) }
        }
    }

    private var todayCard: some View {
        HStack {
            StatTile(value: "\(store.todayAnswered)", label: "今日の問題")
            Divider().frame(height: 36)
            StatTile(value: store.accuracyText, label: "正答率")
            Divider().frame(height: 36)
            StatTile(value: "\(store.streak)日", label: "連続学習")
        }
        .card()
    }

    private var startCard: some View {
        Button {
            session = QuizSession(title: "出る順で10問", questions: store.nextSet(10))
        } label: {
            HStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("出る順で10問")
                        .font(.title2.weight(.bold))
                    Text("よく出る論点の、まだ解いていない・間違えた問題から")
                        .font(.footnote)
                        .opacity(0.85)
                        .multilineTextAlignment(.leading)
                }
                Spacer()
                Image(systemName: "play.circle.fill")
                    .font(.system(size: 44))
            }
            .foregroundStyle(.white)
            .padding(20)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Theme.gradient, in: RoundedRectangle(cornerRadius: 22, style: .continuous))
        }
        .buttonStyle(.plain)
    }

    private var reviewCard: some View {
        Button {
            session = QuizSession(title: "復習", questions: store.reviewQueue)
        } label: {
            HStack {
                Image(systemName: "arrow.counterclockwise.circle.fill")
                    .font(.title)
                    .foregroundStyle(Theme.bad)
                VStack(alignment: .leading, spacing: 2) {
                    Text("復習 \(store.reviewQueue.count)問")
                        .font(.headline)
                        .foregroundStyle(.primary)
                    Text("間違えた問題・復習のタイミングが来た問題")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                Image(systemName: "chevron.right").foregroundStyle(.tertiary)
            }
            .card()
        }
        .buttonStyle(.plain)
    }

    private var topSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("出る順トップ5")
                .font(.headline)
            VStack(spacing: 0) {
                ForEach(Array(store.rankedTopics.prefix(5))) { t in
                    NavigationLink(value: t) {
                        HStack {
                            TopicRow(topic: t)
                            Image(systemName: "chevron.right")
                                .font(.caption)
                                .foregroundStyle(.tertiary)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                    }
                    .buttonStyle(.plain)
                    if t.id != store.rankedTopics.prefix(5).last?.id {
                        Divider().padding(.leading, 60)
                    }
                }
            }
            .background(Theme.card, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
        }
    }
}
