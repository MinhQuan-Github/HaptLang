import SwiftUI
import HaptLang

@main
struct HaptLangExampleApp: App {
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .withHaptLang()
        }
    }
}

struct MainTabView: View {
    @ObservedObject var langManager = HaptLangManager.shared
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                ContentScreen()
            }
            .navigationViewStyle(.stack)
            .tag(0)
            .tabItem {
                Label {
                    Text(L10n.contentTitle)
                } icon: {
                    Image(systemName: "doc.text")
                }
            }

            NavigationView {
                SettingsScreen()
            }
            .navigationViewStyle(.stack)
            .tag(1)
            .tabItem {
                Label {
                    Text(L10n.settingsTitle)
                } icon: {
                    Image(systemName: "gear")
                }
            }
        }
        // No .id() modifier - preserves navigation state
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
