// swift-tools-version: 5.5.0
import PackageDescription
let package = Package(
    name: "GplSession",
    platforms: [.iOS(.v11), .macOS(.v10_12)],
    products: [
        .library(
            name: "GplSession",
            targets: ["GplSession"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/metaplex-foundation/solita-swift.git", branch: "main"),
        .package(name: "Beet", url: "https://github.com/metaplex-foundation/beet-swift.git", from: "1.0.7"),
    ],
    targets: [
        .target(
            name: "GplSession",
            dependencies: [
                "Beet",
                .product(name: "BeetSolana", package: "solita-swift"),
            ]
        ),
        .testTarget(
            name: "GplSessionTests",
            dependencies: ["GplSession"]
        ),
    ]
)
