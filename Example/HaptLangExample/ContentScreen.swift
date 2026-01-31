import SwiftUI

/// Screen 1: Content Screen
/// Displays localized content that updates when the language changes
struct ContentScreen: View {
    @ObservedObject var langManager = HaptLangManager.shared

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Header
                VStack(spacing: 8) {
                    Image(systemName: "globe")
                        .font(.system(size: 60))
                        .foregroundColor(.blue)

                    Text(L10n.generalWelcome)
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)

                    Text(L10n.generalDescription)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.top, 20)

                // Greeting Card
                VStack(spacing: 12) {
                    Text(L10n.contentGreeting)
                        .font(.title2)
                        .fontWeight(.semibold)

                    Text(L10n.contentMessage)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(.systemBackground))
                        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 4)
                )
                .padding(.horizontal)

                // Features List
                VStack(alignment: .leading, spacing: 16) {
                    FeatureRow(
                        icon: "bolt.fill",
                        text: L10n.contentFeature1,
                        color: .orange
                    )

                    FeatureRow(
                        icon: "arrow.clockwise",
                        text: L10n.contentFeature2,
                        color: .green
                    )

                    FeatureRow(
                        icon: "swift",
                        text: L10n.contentFeature3,
                        color: .blue
                    )
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(.secondarySystemBackground))
                )
                .padding(.horizontal)

                // Current Language Indicator
                HStack {
                    Text(L10n.settingsCurrentLanguage)
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(langManager.currentLanguage.displayName)
                        .fontWeight(.medium)
                        .foregroundColor(.blue)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.blue.opacity(0.3), lineWidth: 1)
                )
                .padding(.horizontal)

                Spacer(minLength: 40)
            }
        }
        .navigationTitle(L10n.contentTitle)
        .navigationBarTitleDisplayMode(.large)
    }
}

struct FeatureRow: View {
    let icon: String
    let text: String
    let color: Color

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(color)
                .frame(width: 30)

            Text(text)
                .font(.body)

            Spacer()
        }
    }
}

struct ContentScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentScreen()
        }
    }
}
