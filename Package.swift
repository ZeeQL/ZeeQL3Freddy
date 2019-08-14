// swift-tools-version:4.2

import PackageDescription

let package = Package(
  name: "ZeeQL3Freddy",

  products: [
    .library(name: "ZeeQL3Freddy", targets: [ "ZeeQL3Freddy" ])
  ],
  dependencies: [
    .package(url: "https://github.com/ZeeQL/ZeeQL3.git",
             from: "0.8.0"),
    .package(url: "https://github.com/modswift/Freddy.git",
             from: "3.0.58")
  ],
  targets: [
    .target(name: "ZeeQL3Freddy", dependencies: [ "ZeeQL", "Freddy" ])
  ]
)
