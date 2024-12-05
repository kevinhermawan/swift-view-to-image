# ViewToImage

Convert SwiftUI views to images in a variety of formats.

## Overview

`ViewToImage` lets you turn SwiftUI views into images in common formats like HEIC, JPEG, and PNG.

## Installation

You can add `ViewToImage` as a dependency to your project using Swift Package Manager by adding it to the dependencies value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/kevinhermawan/swift-view-to-image.git", .upToNextMajor(from: "1.0.0"))
],
targets: [
    .target(
        /// ...
        dependencies: [.product(name: "ViewToImage", package: "swift-view-to-image")])
]
```

Alternatively, in Xcode:

1. Open your project in Xcode.
2. Click on `File` -> `Swift Packages` -> `Add Package Dependency...`
3. Enter the repository URL: `git@github.com:kevinhermawan/swift-view-to-image.git`
4. Choose the version you want to add. You probably want to add the latest version.
5. Click `Add Package`.

## Documentation

You can find the documentation here: [https://kevinhermawan.github.io/swift-view-to-image/documentation/viewtoimage](https://kevinhermawan.github.io/swift-view-to-image/documentation/viewtoimage)

## Usage

```swift
import SwiftUI
import ViewToImage

struct GreetingView: View {
    var body: some View {
        Text("Hello, World!")
            .padding()
            .background(Color.purple)
    }
}

if let imageData = ViewToImage.png(GreetingView(), size: CGSize(width: 300, height: 100)) {
    print("Image successfully created!")
}
```

## Support

If you find `ViewToImage` helpful and would like to support its development, consider making a donation. Your contribution helps maintain the project and develop new features.

- [GitHub Sponsors](https://github.com/sponsors/kevinhermawan)
- [Buy Me a Coffee](https://buymeacoffee.com/kevinhermawan)

Your support is greatly appreciated! ❤️

## Contributing

Contributions are welcome! Please open an issue or submit a pull request if you have any suggestions or improvements.

## License

This repository is available under the [Apache License 2.0](LICENSE).
