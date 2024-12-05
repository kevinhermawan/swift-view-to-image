// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ViewToImage",
    platforms: [.iOS(.v17), .macOS(.v14)],
    products: [
        .library(
            name: "ViewToImage",
            targets: ["ViewToImage"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-docc-plugin.git", .upToNextMajor(from: "1.4.3"))
    ],
    targets: [
        .target(
            name: "ViewToImage"
        ),
        .testTarget(
            name: "ViewToImageTests",
            dependencies: ["ViewToImage"]
        )
    ]
)
