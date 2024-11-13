// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "MarkovTextGenerator",
    products: [
        .library(
            name: "MarkovTextGenerator",
            targets: ["MarkovTextGenerator"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "MarkovTextGenerator"),
        .testTarget(
            name: "MarkovTextGeneratorTests",
            dependencies: ["MarkovTextGenerator"]
        ),
    ]
)
