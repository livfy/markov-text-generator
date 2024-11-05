// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "MarkovTextGenerator",
    products: [
        .library(
            name: "MarkovTextGenerator",
            targets: ["MarkovTextGenerator"]),
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
