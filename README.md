# HaptLang

Dynamic localization library for iOS with real-time language switching - no app restart required!

[![Swift](https://img.shields.io/badge/Swift-5.5+-orange.svg)](https://swift.org)
[![iOS](https://img.shields.io/badge/iOS-14.0+-blue.svg)](https://developer.apple.com/ios/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

## Features

- Real-time language switching without app restart
- SwiftUI support with `@EnvironmentObject` and `LocalizedText`
- UIKit support with protocol-based approach
- SwiftGen integration for type-safe localized strings
- Automatic language persistence via UserDefaults
- Supports multiple languages (easily extensible)

## Installation

### Swift Package Manager

Add HaptLang to your project via Xcode:

1. File > Add Packages...
2. Enter: `https://github.com/MinhQuan-Github/HaptLang.git`
3. Select version and add to your target

Or add to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/MinhQuan-Github/HaptLang.git", from: "1.0.0")
]
```

### CocoaPods

Add to your `Podfile`:

```ruby
pod 'HaptLang', '~> 1.0'
```

## Quick Start

### SwiftUI

#### 1. Setup your App

```swift
import SwiftUI
import HaptLang

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .withHaptLang() // Inject HaptLangManager
        }
    }
}
```

#### 2. Use in Views

```swift
import SwiftUI
import HaptLang

struct ContentView: View {
    @ObservedObject var langManager = HaptLangManager.shared

    var body: some View {
        VStack {
            // Using LocalizedText (auto-updates)
            LocalizedText("welcome.message")

            // Using SwiftGen L10n (auto-updates with @ObservedObject)
            Text(L10n.contentGreeting)

            // Language picker
            HaptLangPicker(title: "Language", showNativeNames: true)
        }
    }
}
```

### UIKit

#### 1. Conform to HaptLangLocalizable

```swift
import UIKit
import HaptLang

class MyViewController: UIViewController, HaptLangLocalizable {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeToLanguageChanges() // Subscribe to updates
    }

    // Called when language changes
    func updateLocalization() {
        // Using SwiftGen L10n
        titleLabel.text = L10n.contentTitle

        // Using string keys
        descriptionLabel.setHaptLocalizedText("content.description")

        // Navigation title
        navigationItem.setHaptLocalizedTitle("settings.title")
    }
}
```

## Changing Language

```swift
// Set language programmatically
HaptLangManager.shared.setLanguage(.vietnamese)

// Or use convenience method
HaptLang.setLanguage(.japanese)

// Get current language
let current = HaptLang.currentLanguage

// Get all available languages
let languages = HaptLang.availableLanguages
```

## Supported Languages

By default, HaptLang supports:
- English (`.english`)
- Vietnamese (`.vietnamese`)
- Japanese (`.japanese`)

### Adding More Languages

1. Add a new case to the `Language` enum in your app
2. Create the corresponding `.lproj` folder with `Localizable.strings`
3. Regenerate SwiftGen strings if using SwiftGen

## SwiftGen Integration

HaptLang works great with SwiftGen for type-safe strings.

### swiftgen.yml

```yaml
strings:
  inputs:
    - Sources/HaptLang/Resources/en.lproj/Localizable.strings
  outputs:
    - templatePath: swiftgen-template.stencil
      output: Sources/HaptLang/Generated/Strings+Generated.swift
```

### Generate Strings

```bash
swiftgen
```

## API Reference

### HaptLangManager

```swift
// Shared instance
HaptLangManager.shared

// Current language (Observable)
@Published var currentLanguage: Language

// Set language
func setLanguage(_ language: Language)

// Reset to system language
func resetToSystemLanguage()

// Available languages
var availableLanguages: [Language]

// Language change publisher (Combine)
var languagePublisher: AnyPublisher<Language, Never>
```

### SwiftUI Components

```swift
// Localized text view
LocalizedText("key")
LocalizedText("key", arguments: arg1, arg2)

// View modifier for environment injection
.withHaptLang()

// Force view refresh on language change
.haptLangAware()

// Ready-to-use language picker
HaptLangPicker(title: "Language", showNativeNames: true)

// Property wrapper
@HaptLocalized("key") var text: String
```

### UIKit Extensions

```swift
// Subscribe to changes
subscribeToLanguageChanges()

// Unsubscribe
unsubscribeFromLanguageChanges()

// UILabel
label.setHaptLocalizedText("key")

// UIButton
button.setHaptLocalizedTitle("key", for: .normal)

// UITextField
textField.setHaptLocalizedPlaceholder("key")

// UINavigationItem
navigationItem.setHaptLocalizedTitle("key")

// UITabBarItem
tabBarItem.setHaptLocalizedTitle("key")
```

### String Extensions

```swift
// Localize any string
"my.key".haptLocalized

// With specific language
"my.key".haptLocalized(for: .vietnamese)

// With format arguments
"my.key".haptLocalized(with: arg1, arg2)
```

## Example App

The repository includes a complete example app demonstrating:

1. **Content Screen** - Displays localized content
2. **Settings Screen** - Settings with localized labels
3. **Language Selection** - Language picker that updates the app in real-time

Run the example:

```bash
cd Example/HaptLangExample
open HaptLangExample.xcodeproj
```

## Requirements

- iOS 14.0+
- Swift 5.5+
- Xcode 13.0+

## License

HaptLang is available under the MIT license. See the [LICENSE](LICENSE) file for more info.

## Author

MinhQuan-Github

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
