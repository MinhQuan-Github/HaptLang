import SwiftUI
import Combine

// MARK: - Environment Key for HaptLang

@available(iOS 14.0, macOS 11.0, *)
private struct HaptLangEnvironmentKey: EnvironmentKey {
    static let defaultValue: HaptLangManager = .shared
}

@available(iOS 14.0, macOS 11.0, *)
public extension EnvironmentValues {
    /// The HaptLang manager instance
    var haptLang: HaptLangManager {
        get { self[HaptLangEnvironmentKey.self] }
        set { self[HaptLangEnvironmentKey.self] = newValue }
    }
}

// MARK: - View Extensions

@available(iOS 14.0, macOS 11.0, *)
public extension View {
    /// Injects the HaptLangManager into the view hierarchy
    /// - Parameter manager: The HaptLangManager instance (defaults to shared)
    /// - Returns: A view with HaptLangManager available in the environment
    func withHaptLang(_ manager: HaptLangManager = .shared) -> some View {
        self
            .environmentObject(manager)
            .environment(\.haptLang, manager)
    }
}

// MARK: - Reactive Localized String

/// A property wrapper that provides a reactive localized string
@available(iOS 14.0, macOS 11.0, *)
@propertyWrapper
public struct HaptLocalized: DynamicProperty {
    @ObservedObject private var manager = HaptLangManager.shared

    private let key: String
    private let tableName: String?

    public init(_ key: String, tableName: String? = nil) {
        self.key = key
        self.tableName = tableName
    }

    public var wrappedValue: String {
        let bundle = HaptLangBundle.bundle(for: manager.currentLanguage)
        return NSLocalizedString(key, tableName: tableName, bundle: bundle, comment: "")
    }
}

// MARK: - Localized Text Modifier

@available(iOS 14.0, macOS 11.0, *)
public struct LocalizedTextModifier: ViewModifier {
    @ObservedObject private var manager = HaptLangManager.shared

    public init() {}

    public func body(content: Content) -> some View {
        content
            .id(manager.currentLanguage.code) // Force view refresh on language change
    }
}

@available(iOS 14.0, macOS 11.0, *)
public extension View {
    /// Forces the view to refresh when the language changes
    /// Use this on views that need to update their localized content
    func haptLangAware() -> some View {
        modifier(LocalizedTextModifier())
    }
}

// MARK: - Language Picker View

/// A ready-to-use language picker view
@available(iOS 14.0, macOS 11.0, *)
public struct HaptLangPicker: View {
    @ObservedObject private var manager = HaptLangManager.shared

    private let showNativeNames: Bool
    private let title: String?

    /// Creates a language picker
    /// - Parameters:
    ///   - title: Optional title for the picker
    ///   - showNativeNames: Whether to show language names in their native form
    public init(title: String? = nil, showNativeNames: Bool = true) {
        self.title = title
        self.showNativeNames = showNativeNames
    }

    public var body: some View {
        Picker(title ?? "", selection: $manager.currentLanguage) {
            ForEach(Language.allCases) { language in
                Text(showNativeNames ? language.displayName : language.englishName)
                    .tag(language)
            }
        }
    }
}
