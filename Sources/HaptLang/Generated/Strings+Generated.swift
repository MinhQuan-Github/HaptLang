// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen
// Custom template for HaptLang dynamic localization

import Foundation

// MARK: - Strings

public enum L10n {

    // MARK: - General

    /// Welcome to HaptLang
    public static var generalWelcome: String { L10n.tr("Localizable", "general.welcome") }
    /// Dynamic localization for iOS
    public static var generalDescription: String { L10n.tr("Localizable", "general.description") }
    /// Language
    public static var generalLanguage: String { L10n.tr("Localizable", "general.language") }

    // MARK: - Content Screen

    /// Content
    public static var contentTitle: String { L10n.tr("Localizable", "content.title") }
    /// Hello, World!
    public static var contentGreeting: String { L10n.tr("Localizable", "content.greeting") }
    /// This text changes dynamically when you select a different language.
    public static var contentMessage: String { L10n.tr("Localizable", "content.message") }
    /// Real-time language switching
    public static var contentFeature1: String { L10n.tr("Localizable", "content.feature1") }
    /// No app restart required
    public static var contentFeature2: String { L10n.tr("Localizable", "content.feature2") }
    /// Supports SwiftUI and UIKit
    public static var contentFeature3: String { L10n.tr("Localizable", "content.feature3") }

    // MARK: - Settings Screen

    /// Settings
    public static var settingsTitle: String { L10n.tr("Localizable", "settings.title") }
    /// Language
    public static var settingsLanguage: String { L10n.tr("Localizable", "settings.language") }
    /// Current Language
    public static var settingsCurrentLanguage: String { L10n.tr("Localizable", "settings.currentLanguage") }
    /// Select Language
    public static var settingsSelectLanguage: String { L10n.tr("Localizable", "settings.selectLanguage") }
    /// Notifications
    public static var settingsNotifications: String { L10n.tr("Localizable", "settings.notifications") }
    /// Dark Mode
    public static var settingsDarkMode: String { L10n.tr("Localizable", "settings.darkMode") }
    /// About
    public static var settingsAbout: String { L10n.tr("Localizable", "settings.about") }
    /// Version
    public static var settingsVersion: String { L10n.tr("Localizable", "settings.version") }

    // MARK: - Language Selection

    /// Select Language
    public static var languageSelectionTitle: String { L10n.tr("Localizable", "languageSelection.title") }
    /// Choose your preferred language. The app will update immediately.
    public static var languageSelectionDescription: String { L10n.tr("Localizable", "languageSelection.description") }
    /// Current
    public static var languageSelectionCurrent: String { L10n.tr("Localizable", "languageSelection.current") }
}

// MARK: - Implementation Details

extension L10n {
    private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
        let format = NSLocalizedString(key, tableName: table, bundle: HaptLangBundle.current, comment: "")
        return String(format: format, locale: Locale.current, arguments: args)
    }
}
