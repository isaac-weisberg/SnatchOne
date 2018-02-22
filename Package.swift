// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "snatch",
    products: [
        .library(
            name: "snatch",
            targets: ["snatch"]),
    ],
    dependencies: [
        .package(url: "https://github.com/khanlou/Promise.git", .branch("master")),
    ],
    targets: [
        .target(
            name: "snatch",
            dependencies: [ "Promise" ]),
        .testTarget(
            name: "snatchTests",
            dependencies: [ "snatch" ]),
    ]
)
