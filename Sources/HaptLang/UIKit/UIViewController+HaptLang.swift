import Foundation

#if canImport(UIKit)
import UIKit
import Combine

// MARK: - Associated Object Keys

private var haptLangObserverKey: UInt8 = 0
private var haptLangCancellablesKey: UInt8 = 0

// MARK: - UIViewController Extension

public extension UIViewController {
    /// Subscribes to language change notifications
    /// Call this in viewDidLoad() for view controllers that implement HaptLangLocalizable
    func subscribeToLanguageChanges() {
        guard let localizable = self as? HaptLangLocalizable else {
            print("⚠️ HaptLang: \(type(of: self)) does not conform to HaptLangLocalizable")
            return
        }

        // Remove existing observer if any
        unsubscribeFromLanguageChanges()

        // Add observer for language changes
        let observer = NotificationCenter.default.addObserver(
            forName: .haptLangDidChange,
            object: nil,
            queue: .main
        ) { [weak localizable] _ in
            localizable?.updateLocalization()
        }

        // Store observer for cleanup
        objc_setAssociatedObject(
            self,
            &haptLangObserverKey,
            observer,
            .OBJC_ASSOCIATION_RETAIN_NONATOMIC
        )

        // Initial localization update
        localizable.updateLocalization()
    }

    /// Subscribes to language changes using Combine
    /// Useful for iOS 13+ when you want to use Combine instead of NotificationCenter
    @available(iOS 13.0, *)
    func subscribeToLanguageChangesWithCombine() {
        guard let localizable = self as? HaptLangLocalizable else {
            print("⚠️ HaptLang: \(type(of: self)) does not conform to HaptLangLocalizable")
            return
        }

        var cancellables = Set<AnyCancellable>()

        HaptLangManager.shared.languagePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak localizable] _ in
                localizable?.updateLocalization()
            }
            .store(in: &cancellables)

        // Store cancellables for cleanup
        objc_setAssociatedObject(
            self,
            &haptLangCancellablesKey,
            cancellables,
            .OBJC_ASSOCIATION_RETAIN_NONATOMIC
        )

        // Initial localization update
        localizable.updateLocalization()
    }

    /// Unsubscribes from language change notifications
    /// This is called automatically when using the swizzled dealloc, but can be called manually if needed
    func unsubscribeFromLanguageChanges() {
        // Remove NotificationCenter observer
        if let observer = objc_getAssociatedObject(self, &haptLangObserverKey) as? NSObjectProtocol {
            NotificationCenter.default.removeObserver(observer)
            objc_setAssociatedObject(self, &haptLangObserverKey, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }

        // Clear Combine cancellables
        objc_setAssociatedObject(self, &haptLangCancellablesKey, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }

    /// The current language
    var currentHaptLanguage: Language {
        HaptLangManager.shared.currentLanguage
    }

    /// Changes the current language
    /// - Parameter language: The language to switch to
    func setHaptLanguage(_ language: Language) {
        HaptLangManager.shared.setLanguage(language)
    }
}

// MARK: - UILabel Extension

public extension UILabel {
    /// Sets the text using a localization key
    /// - Parameter key: The localization key
    func setHaptLocalizedText(_ key: String) {
        self.text = NSLocalizedString(key, bundle: HaptLangBundle.current, comment: "")
    }
}

// MARK: - UIButton Extension

public extension UIButton {
    /// Sets the title using a localization key
    /// - Parameters:
    ///   - key: The localization key
    ///   - state: The button state (default: .normal)
    func setHaptLocalizedTitle(_ key: String, for state: UIControl.State = .normal) {
        let title = NSLocalizedString(key, bundle: HaptLangBundle.current, comment: "")
        self.setTitle(title, for: state)
    }
}

// MARK: - UITextField Extension

public extension UITextField {
    /// Sets the placeholder using a localization key
    /// - Parameter key: The localization key
    func setHaptLocalizedPlaceholder(_ key: String) {
        self.placeholder = NSLocalizedString(key, bundle: HaptLangBundle.current, comment: "")
    }
}

// MARK: - UINavigationItem Extension

public extension UINavigationItem {
    /// Sets the title using a localization key
    /// - Parameter key: The localization key
    func setHaptLocalizedTitle(_ key: String) {
        self.title = NSLocalizedString(key, bundle: HaptLangBundle.current, comment: "")
    }
}

// MARK: - UITabBarItem Extension

public extension UITabBarItem {
    /// Sets the title using a localization key
    /// - Parameter key: The localization key
    func setHaptLocalizedTitle(_ key: String) {
        self.title = NSLocalizedString(key, bundle: HaptLangBundle.current, comment: "")
    }
}

#endif
