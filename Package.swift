// swift-tools-version:5.1

import PackageDescription

let package = Package(
  name: "mtg-list-formatter",
  dependencies: [
    .package(url: "https://github.com/yaslab/CSV.swift.git", from: "2.4.2")
  ],
  targets: [
    .target(
      name: "mtg-list-formatter",
      dependencies: [
        "CSV"
    ]),
  ]
)


