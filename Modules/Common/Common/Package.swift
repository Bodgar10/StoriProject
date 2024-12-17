// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "Common",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Common",
            targets: ["Common"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Common"),
        .testTarget(
            name: "CommonTests",
            dependencies: ["Common"]),
    ],
    swiftLanguageVersions: [.v5]
)