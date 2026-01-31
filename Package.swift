// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HaptLang",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v14),
        .macOS(.v11)
    ],
    products: [
        .library(
            name: "HaptLang",
            targets: ["HaptLang"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "HaptLang",
            dependencies: [],
            path: "Sources/HaptLang",
            resources: [
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "HaptLangTests",
            dependencies: ["HaptLang"]
        ),
    ]
)
