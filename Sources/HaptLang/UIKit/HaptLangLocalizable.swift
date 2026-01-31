import Foundation

#if canImport(UIKit)
import UIKit

/// Protocol for UIKit view controllers that need to respond to language changes
public protocol HaptLangLocalizable: AnyObject {
    /// Called when the language changes. Implement this to update your UI.
    func updateLocalization()
}

/// Extension to provide default behavior and helpers
public extension HaptLangLocalizable {
    /// Returns a localized string for the given key
    /// - Parameter key: The localization key
    /// - Returns: The localized string
    func haptLocalized(_ key: String) -> String {
        return NSLocalizedString(key, bundle: HaptLangBundle.current, comment: "")
    }

    /// Returns a localized string with format arguments
    /// - Parameters:
    ///   - key: The localization key
    ///   - arguments: Format arguments
    /// - Returns: The formatted localized string
    func haptLocalized(_ key: String, arguments: CVarArg...) -> String {
        let format = haptLocalized(key)
        return String(format: format, arguments: arguments)
    }
}

#endif
