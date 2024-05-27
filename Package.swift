// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AwtrixKit",
    platforms: [
        .iOS(.v13),
        .macOS(.v13),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: "AwtrixKit",
            targets: ["AwtrixKit"]
        )
    ],
    targets: [
        .target(
            name: "AwtrixKit"
        ),
        .testTarget(
            name: "AwtrixKitTests",
            dependencies: ["AwtrixKit"]
        )
    ]
)
