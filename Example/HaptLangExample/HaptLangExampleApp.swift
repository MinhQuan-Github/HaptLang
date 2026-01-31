import SwiftUI

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

    var body: some View {
        TabView {
            NavigationView {
                ContentScreen()
            }
            .tabItem {
                Image(systemName: "doc.text")
                Text(L10n.contentTitle)
            }

            NavigationView {
                SettingsScreen()
            }
            .tabItem {
                Image(systemName: "gear")
                Text(L10n.settingsTitle)
            }
        }
        .id(langManager.currentLanguage.code) // Force tab bar to update
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
