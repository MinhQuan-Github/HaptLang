import Foundation

/// Represents supported languages in HaptLang
public enum Language: String, CaseIterable, Identifiable {
    case english = "en"
    case vietnamese = "vi"
    case japanese = "ja"

    public var id: String { rawValue }

    /// The language code used for bundle lookup
    public var code: String { rawValue }

    /// Display name of the language in its native form
    public var displayName: String {
        switch self {
        case .english: return "English"
        case .vietnamese: return "Tiếng Việt"
        case .japanese: return "日本語"
        }
    }

    /// Display name of the language in English
    public var englishName: String {
        switch self {
        case .english: return "English"
        case .vietnamese: return "Vietnamese"
        case .japanese: return "Japanese"
        }
    }

    /// The lproj folder name for this language
    public var lprojName: String {
        return "\(code).lproj"
    }

    /// Creates a Language from a locale identifier
    public static func from(localeIdentifier: String) -> Language? {
        let code = String(localeIdentifier.prefix(2))
        return Language(rawValue: code)
    }

    /// Returns the system's preferred language if supported, otherwise returns English
    public static var systemPreferred: Language {
        if let preferredLanguage = Locale.preferredLanguages.first,
           let language = Language.from(localeIdentifier: preferredLanguage) {
            return language
        }
        return .english
    }
}
