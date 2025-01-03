// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "CMUDict",
    products: [
        .library(
            name: "CMUDict",
            targets: ["CMUDict"]),
    ],
    targets: [
        .target(
            name: "CMUDict", resources: [.copy("cmudict.txt")]),
        .testTarget(
            name: "CMUDictTests",
            dependencies: ["CMUDict"]
        ),
    ]
)
