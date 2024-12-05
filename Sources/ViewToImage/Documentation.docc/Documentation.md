# ``ViewToImage``

Convert SwiftUI views to images in a variety of formats.

## Overview

``ViewToImage`` lets you turn SwiftUI views into images in common formats like HEIC, JPEG, and PNG.

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
