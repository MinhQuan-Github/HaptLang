// HaptLang - Dynamic Localization Library for iOS
// Author: MinhQuan-Github
// License: MIT

import Foundation

/// HaptLang is a dynamic localization library for iOS that allows real-time
/// language switching without requiring an app restart.
///
/// ## Quick Start - SwiftUI
///
/// ```swift
/// @main
/// struct MyApp: App {
///     var body: some Scene {
///         WindowGroup {
///             ContentView()
///                 .withHaptLang()
///         }
///     }
/// }
///
/// struct ContentView: View {
///     @ObservedObject var langManager = HaptLangManager.shared
///
///     var body: some View {
///         VStack {
///             LocalizedText("welcome.message")
///             Text(L10n.contentGreeting)
///         }
///     }
/// }
/// ```
///
/// ## Quick Start - UIKit
///
/// ```swift
/// class MyViewController: UIViewController, HaptLangLocalizable {
///     override func viewDidLoad() {
///         super.viewDidLoad()
///         subscribeToLanguageChanges()
///     }
///
///     func updateLocalization() {
///         titleLabel.text = L10n.contentTitle
///         // or
///         titleLabel.setHaptLocalizedText("content.title")
///     }
/// }
/// ```
///
/// ## Changing Language
///
/// ```swift
/// HaptLangManager.shared.setLanguage(.vietnamese)
/// ```
///
public struct HaptLang {
    /// The current version of HaptLang
    public static let version = "1.0.0"

    /// The shared HaptLangManager instance
    public static var shared: HaptLangManager {
        HaptLangManager.shared
    }

    /// Convenience method to set the current language
    /// - Parameter language: The language to switch to
    public static func setLanguage(_ language: Language) {
        HaptLangManager.shared.setLanguage(language)
    }

    /// Convenience method to get the current language
    public static var currentLanguage: Language {
        HaptLangManager.shared.currentLanguage
    }

    /// Convenience method to get all available languages
    public static var availableLanguages: [Language] {
        Language.allCases
    }

    /// Registers a custom bundle for localization resources
    /// - Parameter bundle: The bundle containing localization resources
    public static func registerBundle(_ bundle: Bundle) {
        HaptLangBundle.registerResourceBundle(bundle)
    }

    private init() {}
}
