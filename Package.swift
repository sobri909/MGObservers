// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MGObservers",
    platforms: [.iOS(.v9)],
    products: [
        .library(name: "MGObservers", targets: ["MGObservers"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "MGObservers",
            dependencies: [], 
            path: "MGObservers"
        )
    ]
)
