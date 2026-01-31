import SwiftUI

/// A SwiftUI View that displays localized text and automatically updates when the language changes
@available(iOS 14.0, macOS 11.0, *)
public struct LocalizedText: View {
    @ObservedObject private var manager = HaptLangManager.shared

    private let key: String
    private let tableName: String?
    private let arguments: [CVarArg]

    /// Creates a LocalizedText view with a localization key
    /// - Parameters:
    ///   - key: The localization key
    ///   - tableName: The table name (default: "Localizable")
    public init(_ key: String, tableName: String? = nil) {
        self.key = key
        self.tableName = tableName
        self.arguments = []
    }

    /// Creates a LocalizedText view with a localization key and format arguments
    /// - Parameters:
    ///   - key: The localization key
    ///   - tableName: The table name (default: "Localizable")
    ///   - arguments: Format arguments
    public init(_ key: String, tableName: String? = nil, arguments: CVarArg...) {
        self.key = key
        self.tableName = tableName
        self.arguments = arguments
    }

    public var body: some View {
        Text(localizedString)
    }

    private var localizedString: String {
        let bundle = HaptLangBundle.bundle(for: manager.currentLanguage)
        let format = NSLocalizedString(key, tableName: tableName, bundle: bundle, comment: "")
        if arguments.isEmpty {
            return format
        }
        return String(format: format, arguments: arguments)
    }
}

// MARK: - Preview
@available(iOS 14.0, macOS 11.0, *)
struct LocalizedText_Previews: PreviewProvider {
    static var previews: some View {
        LocalizedText("general.welcome")
    }
}
