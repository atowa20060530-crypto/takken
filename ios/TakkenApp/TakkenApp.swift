import SwiftUI

@main
struct TakkenApp: App {
    @State private var store = StudyStore()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(store)
                .tint(Theme.accent)
        }
    }
}

struct RootView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem { Label("ホーム", systemImage: "house") }
            RankingView()
                .tabItem { Label("出る順", systemImage: "list.number") }
            PracticeView()
                .tabItem { Label("問題", systemImage: "square.and.pencil") }
            StatsView()
                .tabItem { Label("記録", systemImage: "chart.bar.xaxis") }
        }
    }
}
