import Foundation
import Combine

/// Notification posted when the language changes
public extension Notification.Name {
    static let haptLangDidChange = Notification.Name("HaptLangDidChangeNotification")
}

/// Keys for notification userInfo
public enum HaptLangNotificationKey: String {
    case newLanguage = "newLanguage"
    case oldLanguage = "oldLanguage"
}

/// The main manager for HaptLang localization
/// Use this as an ObservableObject in SwiftUI or subscribe to notifications in UIKit
public final class HaptLangManager: ObservableObject {
    /// Shared singleton instance
    public static let shared = HaptLangManager()

    /// UserDefaults key for persisting language preference
    private static let languageKey = "HaptLang.selectedLanguage"

    /// The currently selected language
    /// Changes to this property trigger UI updates in SwiftUI and post notifications for UIKit
    @Published public var currentLanguage: Language {
        didSet {
            if oldValue != currentLanguage {
                persistLanguage()
                postLanguageChangeNotification(from: oldValue, to: currentLanguage)
            }
        }
    }

    /// Publisher for language changes
    public var languagePublisher: AnyPublisher<Language, Never> {
        $currentLanguage.eraseToAnyPublisher()
    }

    /// Private initializer to enforce singleton pattern
    private init() {
        self.currentLanguage = Self.loadPersistedLanguage()
    }

    /// Sets the current language
    /// - Parameter language: The language to switch to
    public func setLanguage(_ language: Language) {
        currentLanguage = language
    }

    /// Resets to the system's preferred language
    public func resetToSystemLanguage() {
        currentLanguage = Language.systemPreferred
    }

    /// Returns all available languages
    public var availableLanguages: [Language] {
        Language.allCases
    }

    // MARK: - Persistence

    private func persistLanguage() {
        UserDefaults.standard.set(currentLanguage.rawValue, forKey: Self.languageKey)
        UserDefaults.standard.synchronize()
    }

    private static func loadPersistedLanguage() -> Language {
        if let savedCode = UserDefaults.standard.string(forKey: languageKey),
           let language = Language(rawValue: savedCode) {
            return language
        }
        return Language.systemPreferred
    }

    /// Clears the persisted language preference
    public func clearPersistedLanguage() {
        UserDefaults.standard.removeObject(forKey: Self.languageKey)
        UserDefaults.standard.synchronize()
    }

    // MARK: - Notifications (for UIKit)

    private func postLanguageChangeNotification(from oldLanguage: Language, to newLanguage: Language) {
        NotificationCenter.default.post(
            name: .haptLangDidChange,
            object: self,
            userInfo: [
                HaptLangNotificationKey.oldLanguage.rawValue: oldLanguage,
                HaptLangNotificationKey.newLanguage.rawValue: newLanguage
            ]
        )
    }

    // MARK: - Localization Helpers

    /// Returns a localized string for the given key
    /// - Parameter key: The localization key
    /// - Returns: The localized string
    public func localizedString(for key: String) -> String {
        return NSLocalizedString(key, bundle: HaptLangBundle.current, comment: "")
    }

    /// Returns a localized string with format arguments
    /// - Parameters:
    ///   - key: The localization key
    ///   - arguments: The format arguments
    /// - Returns: The formatted localized string
    public func localizedString(for key: String, arguments: CVarArg...) -> String {
        let format = localizedString(for: key)
        return String(format: format, arguments: arguments)
    }
}

// MARK: - Convenience Type Alias
public typealias L = HaptLangManager
