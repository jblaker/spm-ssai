// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.
// https://developer.apple.com/documentation/xcode/creating_a_standalone_swift_package_with_xcode?language=objc

import PackageDescription

let BrightcovePlayerSDK = Package(
    name: "SSAI Plugin for Brightcove Player SDK",
    platforms: [
        .iOS(.v11), .tvOS(.v11)
    ],
    products: [
        .library(
            name: "BrightcoveSSAI",
            targets: ["BrightcoveSSAITarget"])
    ],
    dependencies: [    
        .package(url: "https://github.com/jblaker/spm-core.git", brancn: "master")
    ],
    targets: [
        .target(
              name: "BrightcoveSSAITarget",
              dependencies: [.target(name: "BrightcoveSSAIWrapper",
                                     condition: .when(platforms: [.iOS]))]
            ),
        .target(
              name: "BrightcoveSSAIWrapper",
              dependencies: [
                .target(name: "BrightcoveSSAI", condition: .when(platforms: [.iOS, .tvOS])),
                .product(name: "BrightcovePlayerSDK", package: "BrightcovePlayerSDK")
              ]
            ),
        .binaryTarget(
            name: "BrightcoveSSAI",
            path: "xcframework/BrightcoveSSAI.xcframework"
        )
    ]
)
