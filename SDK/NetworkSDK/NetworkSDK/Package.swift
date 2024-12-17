// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "NetworkSDK",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "NetworkSDK",
            targets: ["NetworkSDK"]),
    ],
    dependencies: [
        .package(path: "../../../Modules/Common/Common"),
        .package(path: "../../../Modules/DesignSystem/DesignSystem"),
        .package(path: "../../../Modules/Switchboard/Switchboard"),
    ],
    targets: [
        .target(
            name: "NetworkSDK",
            dependencies:
                [
                    .product(name: "Common", package: "Common"),
                    .product(name: "DesignSystem", package: "DesignSystem"),
                    .product(name: "Switchboard", package: "Switchboard"),
                ]
        ),
        .testTarget(
            name: "NetworkSDKTests",
            dependencies: ["NetworkSDK"]),
    ],
    swiftLanguageVersions: [.v5]
)
