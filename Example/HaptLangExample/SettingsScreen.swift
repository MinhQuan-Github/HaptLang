import SwiftUI
import HaptLang

/// Screen 2: Settings Screen
/// Shows various settings options with localized labels
struct SettingsScreen: View {
    @ObservedObject var langManager = HaptLangManager.shared
    @State private var notificationsEnabled = true
    @State private var darkModeEnabled = false
    @State private var showingLanguageSelection = false

    var body: some View {
        List {
            // Language Section
            Section {
                Button {
                    showingLanguageSelection = true
                } label: {
                    HStack {
                        Label {
                            Text(L10n.settingsLanguage)
                                .foregroundColor(.primary)
                        } icon: {
                            Image(systemName: "globe")
                                .foregroundColor(.blue)
                        }

                        Spacer()

                        Text(langManager.currentLanguage.displayName)
                            .foregroundColor(.secondary)

                        Image(systemName: "chevron.right")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            } header: {
                Text(L10n.generalLanguage)
            }

            // Preferences Section
            Section {
                Toggle(isOn: $notificationsEnabled) {
                    Label {
                        Text(L10n.settingsNotifications)
                    } icon: {
                        Image(systemName: "bell.badge")
                            .foregroundColor(.red)
                    }
                }

                Toggle(isOn: $darkModeEnabled) {
                    Label {
                        Text(L10n.settingsDarkMode)
                    } icon: {
                        Image(systemName: "moon.fill")
                            .foregroundColor(.purple)
                    }
                }
            }

            // About Section
            Section {
                HStack {
                    Label {
                        Text(L10n.settingsVersion)
                    } icon: {
                        Image(systemName: "info.circle")
                            .foregroundColor(.gray)
                    }

                    Spacer()

                    Text(HaptLang.version)
                        .foregroundColor(.secondary)
                }

                NavigationLink {
                    AboutView()
                } label: {
                    Label {
                        Text(L10n.settingsAbout)
                    } icon: {
                        Image(systemName: "questionmark.circle")
                            .foregroundColor(.blue)
                    }
                }
            }
        }
        .navigationTitle(L10n.settingsTitle)
        .navigationBarTitleDisplayMode(.large)
        .sheet(isPresented: $showingLanguageSelection) {
            NavigationView {
                if #available(iOS 15.0, *) {
                    LanguageSelectionScreen()
                } else {
                    EmptyView()
                }
            }
        }
    }
}

struct AboutView: View {
    @ObservedObject var langManager = HaptLangManager.shared

    var body: some View {
        VStack(spacing: 20) {
            Spacer()

            Image(systemName: "globe.americas.fill")
                .font(.system(size: 80))
                .foregroundColor(.blue)

            Text("HaptLang")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text(L10n.generalDescription)
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)

            Text("v\(HaptLang.version)")
                .font(.caption)
                .foregroundColor(.secondary)

            Spacer()

            Text("Made by MinhQuan-Github")
                .font(.footnote)
                .foregroundColor(.secondary)
                .padding(.bottom, 40)
        }
        .navigationTitle(L10n.settingsAbout)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SettingsScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsScreen()
        }
    }
}
