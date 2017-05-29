import PackageDescription

let package = Package(
  name: "ZeeQL3Freddy",

  targets: [
    Target(name: "ZeeQL3Freddy")
  ],
  
  dependencies: [
    .Package(url: "https://github.com/ZeeQL/ZeeQL3.git",  majorVersion: 0),
    .Package(url: "https://github.com/modswift/Freddy.git",
             majorVersion: 3, minor: 0)
  ],
  
  exclude: [
    "ZeeQL3Freddy.xcodeproj",
    "GNUmakefile",
    "LICENSE",
    "README.md",
    "xcconfig"
  ]
)
