import XCTest
@testable import HaptLang

final class HaptLangTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Reset to English before each test
        HaptLangManager.shared.setLanguage(.english)
    }

    override func tearDown() {
        super.tearDown()
        HaptLangManager.shared.clearPersistedLanguage()
    }

    // MARK: - Language Tests

    func testLanguageCode() {
        XCTAssertEqual(Language.english.code, "en")
        XCTAssertEqual(Language.vietnamese.code, "vi")
        XCTAssertEqual(Language.japanese.code, "ja")
    }

    func testLanguageDisplayName() {
        XCTAssertEqual(Language.english.displayName, "English")
        XCTAssertEqual(Language.vietnamese.displayName, "Tiếng Việt")
        XCTAssertEqual(Language.japanese.displayName, "日本語")
    }

    func testLanguageEnglishName() {
        XCTAssertEqual(Language.english.englishName, "English")
        XCTAssertEqual(Language.vietnamese.englishName, "Vietnamese")
        XCTAssertEqual(Language.japanese.englishName, "Japanese")
    }

    func testLanguageLprojName() {
        XCTAssertEqual(Language.english.lprojName, "en.lproj")
        XCTAssertEqual(Language.vietnamese.lprojName, "vi.lproj")
        XCTAssertEqual(Language.japanese.lprojName, "ja.lproj")
    }

    func testLanguageFromLocaleIdentifier() {
        XCTAssertEqual(Language.from(localeIdentifier: "en-US"), .english)
        XCTAssertEqual(Language.from(localeIdentifier: "vi-VN"), .vietnamese)
        XCTAssertEqual(Language.from(localeIdentifier: "ja-JP"), .japanese)
        XCTAssertNil(Language.from(localeIdentifier: "fr-FR"))
    }

    // MARK: - HaptLangManager Tests

    func testManagerSingleton() {
        let manager1 = HaptLangManager.shared
        let manager2 = HaptLangManager.shared
        XCTAssertTrue(manager1 === manager2)
    }

    func testSetLanguage() {
        let manager = HaptLangManager.shared

        manager.setLanguage(.vietnamese)
        XCTAssertEqual(manager.currentLanguage, .vietnamese)

        manager.setLanguage(.japanese)
        XCTAssertEqual(manager.currentLanguage, .japanese)

        manager.setLanguage(.english)
        XCTAssertEqual(manager.currentLanguage, .english)
    }

    func testAvailableLanguages() {
        let manager = HaptLangManager.shared
        let languages = manager.availableLanguages

        XCTAssertEqual(languages.count, 3)
        XCTAssertTrue(languages.contains(.english))
        XCTAssertTrue(languages.contains(.vietnamese))
        XCTAssertTrue(languages.contains(.japanese))
    }

    // MARK: - HaptLang Convenience Tests

    func testHaptLangVersion() {
        XCTAssertEqual(HaptLang.version, "1.0.0")
    }

    func testHaptLangSetLanguage() {
        HaptLang.setLanguage(.vietnamese)
        XCTAssertEqual(HaptLang.currentLanguage, .vietnamese)
    }

    func testHaptLangAvailableLanguages() {
        XCTAssertEqual(HaptLang.availableLanguages.count, 3)
    }

    // MARK: - Notification Tests

    func testLanguageChangeNotification() {
        let expectation = XCTestExpectation(description: "Language change notification")
        var receivedOldLanguage: Language?
        var receivedNewLanguage: Language?

        let observer = NotificationCenter.default.addObserver(
            forName: .haptLangDidChange,
            object: nil,
            queue: .main
        ) { notification in
            receivedOldLanguage = notification.userInfo?[HaptLangNotificationKey.oldLanguage.rawValue] as? Language
            receivedNewLanguage = notification.userInfo?[HaptLangNotificationKey.newLanguage.rawValue] as? Language
            expectation.fulfill()
        }

        HaptLangManager.shared.setLanguage(.japanese)

        wait(for: [expectation], timeout: 1.0)

        XCTAssertEqual(receivedOldLanguage, .english)
        XCTAssertEqual(receivedNewLanguage, .japanese)

        NotificationCenter.default.removeObserver(observer)
    }
}
