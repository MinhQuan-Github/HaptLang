Pod::Spec.new do |s|
  s.name             = 'HaptLang'
  s.version          = '1.0.0'
  s.summary          = 'Dynamic localization library for iOS with real-time language switching.'

  s.description      = <<-DESC
HaptLang is a dynamic localization library for iOS that enables real-time language
switching without requiring an app restart. It supports both SwiftUI and UIKit,
and integrates seamlessly with SwiftGen for type-safe string access.

Features:
- Real-time language switching without app restart
- SwiftUI support with @EnvironmentObject and LocalizedText
- UIKit support with protocol-based approach and NotificationCenter
- SwiftGen integration for type-safe localized strings
- Automatic language persistence via UserDefaults
- Easy to integrate and use
                       DESC

  s.homepage         = 'https://github.com/MinhQuan-Github/HaptLang'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'MinhQuan-Github' => 'minhquan@example.com' }
  s.source           = { :git => 'https://github.com/MinhQuan-Github/HaptLang.git', :tag => s.version.to_s }

  s.ios.deployment_target = '14.0'
  s.swift_versions = ['5.5', '5.6', '5.7', '5.8', '5.9']

  s.source_files = 'Sources/HaptLang/**/*.swift'
  s.resources = 'Sources/HaptLang/Resources/**/*.strings'

  s.frameworks = 'Foundation', 'UIKit', 'SwiftUI', 'Combine'
end
