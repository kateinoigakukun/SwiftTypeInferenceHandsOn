// swift-tools-version:5.1

import PackageDescription

let rpath = "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/swift/macosx"

let package = Package(
    name: "SwiftTypeInference",
    products: [
      .library(name: "SwiftcAST", targets: ["SwiftcAST"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-syntax.git",
                 .exact("0.50100.0")),
    ],
    targets: [
        .target(
            name: "SwiftcBasic",
            dependencies: []
        ),
        .target(
            name: "SwiftcType",
            dependencies: ["SwiftcBasic"]
        ),
        .target(
            name: "SwiftcAST",
            dependencies: ["SwiftSyntax", "SwiftcBasic", "SwiftcType"]
        ),
        .target(
            name: "SwiftcSema",
            dependencies: ["SwiftcBasic", "SwiftcType", "SwiftcAST"]
        ),
        .target(
            name: "SwiftcTest",
            dependencies: ["SwiftcBasic", "SwiftcType", "SwiftcAST", "SwiftcSema"]
        ),
        .target(
            name: "SwiftCompiler",
            dependencies: ["SwiftcAST", "SwiftcSema"]
        ),
        .target(
            name: "swsc",
            dependencies: ["SwiftcAST", "SwiftcSema"],
            linkerSettings: [
                .unsafeFlags(["-rpath", rpath])
            ]
        ),
        .testTarget(
            name: "SwiftTypeInferenceTests",
            dependencies: ["SwiftcTest", "SwiftcAST", "SwiftcSema"],
            linkerSettings: [
                .unsafeFlags(["-rpath", rpath])
            ]
        )
    ]
)
