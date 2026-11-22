import SwiftUI

struct RankingView: View {
    @Environment(StudyStore.self) private var store
    @State private var filter: Subject? = nil

    private var topics: [Topic] {
        store.rankedTopics.filter { filter == nil || $0.subject == filter }
    }

    var body: some View {
        NavigationStack {
            List {
                Section {
                    Picker("科目", selection: $filter) {
                        Text("すべて").tag(Subject?.none)
                        ForEach(Subject.allCases) { s in
                            Text(s.shortName).tag(Subject?.some(s))
                        }
                    }
                    .pickerStyle(.segmented)
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets())
                }
                Section {
                    ForEach(topics) { t in
                        NavigationLink(value: t) { TopicRow(topic: t) }
                    }
                } footer: {
                    Text("類題を含めた過去10年の出題数（目安）が多い順。S＝毎年複数問、A＝ほぼ毎年、B＝よく出る、C＝ときどき。")
                }
            }
            .navigationTitle("出る順")
            .navigationDestination(for: Topic.self) { TopicDetailView(topic: $0) }
        }
    }
}

struct TopicDetailView: View {
    let topic: Topic
    @Environment(StudyStore.self) private var store
    @Environment(\.openURL) private var openURL
    @State private var session: QuizSession?

    var body: some View {
        let qs = store.questions(for: topic)
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                header
                VStack(alignment: .leading, spacing: 10) {
                    Text("要点").font(.headline)
                    ForEach(topic.points, id: \.self) { p in
                        HStack(alignment: .top, spacing: 8) {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundStyle(Theme.accent)
                                .font(.footnote)
                                .padding(.top, 2)
                            Text(p)
                                .font(.callout)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                }
                .card()

                HStack(spacing: 12) {
                    Button {
                        openURL(topic.youtubeURL)
                    } label: {
                        Label("解説動画", systemImage: "play.rectangle.fill")
                            .font(.subheadline.weight(.semibold))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(Color.red.opacity(0.12), in: RoundedRectangle(cornerRadius: 14, style: .continuous))
                            .foregroundStyle(.red)
                    }
                    Button {
                        session = QuizSession(title: topic.title, questions: qs)
                    } label: {
                        Label("\(qs.count)問解く", systemImage: "pencil")
                            .font(.subheadline.weight(.semibold))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(Theme.accent, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
                            .foregroundStyle(.white)
                    }
                    .disabled(qs.isEmpty)
                }
                .buttonStyle(.plain)

                Text("問題").font(.headline).padding(.top, 4)
                ForEach(qs) { q in QuestionRow(question: q) }
            }
            .padding(16)
        }
        .background(Theme.background)
        .navigationTitle(topic.title)
        .navigationBarTitleDisplayMode(.inline)
        .fullScreenCover(item: $session) { QuizView(session: $0).environment(store) }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 8) {
                GradeBadge(grade: topic.grade)
                Text("出る順 \(store.rank(of: topic))位 · \(topic.grade.caption)")
                    .font(.subheadline.weight(.semibold))
                Spacer()
                SubjectTag(subject: topic.subject)
            }
            Text(topic.summary)
                .font(.body)
                .fixedSize(horizontal: false, vertical: true)
            Text("類題を含む過去10年の出題：約\(topic.estimatedCount)問（目安）")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}
