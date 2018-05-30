// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "Snatch",
    products: [
        .library(
            name: "Snatch",
            targets: ["Snatch"]),
    ],
    dependencies: [
        .package(url: "https://github.com/khanlou/Promise.git", .branch("master")),
        .package(url: "https://github.com/isaac-weisberg/snatchBase.git", .branch("master")),
    ],
    targets: [
        .target(
            name: "Snatch",
            dependencies: [ "Promise", "SnatchBase" ]),
        .testTarget(
            name: "SnatchTests",
            dependencies: [ "Snatch" ]),
    ]
)
