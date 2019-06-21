// swift-tools-version:5.1
import PackageDescription

let package = Package(
  name: "ChatServer",
  products: [
    .library(name: "ChatServer", targets: ["App"]),
  ],
  dependencies: [
    .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0")
  ],
  targets: [
    .target(name: "App", dependencies: ["Vapor"]),
    .target(name: "Run", dependencies: ["App"])
  ]
)

