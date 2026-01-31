import SwiftUI
import HaptLang

/// Screen 3: Language Selection Screen
/// Allows users to select their preferred language
struct LanguageSelectionScreen: View {
    @ObservedObject var langManager = HaptLangManager.shared
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        List {
            Section {
                Text(L10n.languageSelectionDescription)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.vertical, 8)
            }

            Section {
                ForEach(Language.allCases) { language in
                    LanguageRow(
                        language: language,
                        isSelected: langManager.currentLanguage == language
                    ) {
                        langManager.setLanguage(language)
                    }
                }
            }
        }
        .navigationTitle(L10n.languageSelectionTitle)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}

struct LanguageRow: View {
    let language: Language
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(language.displayName)
                        .font(.body)
                        .foregroundColor(.primary)

                    Text(language.englishName)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                Spacer()

                if isSelected {
                    HStack(spacing: 8) {
                        Text(L10n.languageSelectionCurrent)
                            .font(.caption)
                            .foregroundColor(.blue)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(
                                Capsule()
                                    .fill(Color.blue.opacity(0.1))
                            )

                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.blue)
                            .font(.title3)
                    }
                }
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct LanguageSelectionScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LanguageSelectionScreen()
        }
    }
}
