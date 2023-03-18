// swift-tools-version: 5.5.0
import PackageDescription
let package = Package(
    name: "gpl_session",
    platforms: [.iOS(.v11), .macOS(.v10_12)],
        products: [
            .library(
                name: "gpl_session",
                targets: ["gpl_session"]),
    ],
    dependencies: [
        .package(url: "https://github.com/metaplex-foundation/solita-swift.git", branch: "main"),
        .package(name: "Beet", url: "https://github.com/metaplex-foundation/beet-swift.git", from: "1.0.7"),
    ],
    targets: [
        .target(
            name: "gpl_session",
            dependencies: [
                "Beet",
                .product(name: "BeetSolana", package: "solita-swift")
            ]),
    ]
)