import Foundation

/// Manages bundle loading for localized resources
public final class HaptLangBundle {
    /// The main bundle containing localization resources
    private static var resourceBundle: Bundle = {
        #if SWIFT_PACKAGE
        return Bundle.module
        #else
        return Bundle(for: HaptLangBundle.self)
        #endif
    }()

    /// Cache for language-specific bundles
    private static var bundleCache: [Language: Bundle] = [:]

    /// Returns the bundle for the specified language
    /// - Parameter language: The language to get the bundle for
    /// - Returns: The bundle containing localized resources for the language
    public static func bundle(for language: Language) -> Bundle {
        if let cachedBundle = bundleCache[language] {
            return cachedBundle
        }

        guard let path = resourceBundle.path(forResource: language.code, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            return resourceBundle
        }

        bundleCache[language] = bundle
        return bundle
    }

    /// Returns the current bundle based on HaptLangManager's selected language
    public static var current: Bundle {
        return bundle(for: HaptLangManager.shared.currentLanguage)
    }

    /// Clears the bundle cache
    public static func clearCache() {
        bundleCache.removeAll()
    }

    /// Registers a custom resource bundle for HaptLang
    /// - Parameter bundle: The bundle containing localization resources
    public static func registerResourceBundle(_ bundle: Bundle) {
        resourceBundle = bundle
        clearCache()
    }
}

// MARK: - String Localization Extension
public extension String {
    /// Returns the localized string using HaptLang's current language
    var haptLocalized: String {
        return NSLocalizedString(self, bundle: HaptLangBundle.current, comment: "")
    }

    /// Returns the localized string for a specific language
    /// - Parameter language: The language to localize for
    /// - Returns: The localized string
    func haptLocalized(for language: Language) -> String {
        return NSLocalizedString(self, bundle: HaptLangBundle.bundle(for: language), comment: "")
    }

    /// Returns the localized string with format arguments using HaptLang's current language
    /// - Parameter arguments: The format arguments
    /// - Returns: The formatted localized string
    func haptLocalized(with arguments: CVarArg...) -> String {
        return String(format: haptLocalized, arguments: arguments)
    }
}
