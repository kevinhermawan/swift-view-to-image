//
//  ViewToImageTests.swift
//  ViewToImage
//
//  Created by Kevin Hermawan on 12/5/24.
//

import Testing
import SwiftUI
@testable import ViewToImage

struct TestView: View {
    var body: some View {
        Text("Hello, World!")
            .font(.largeTitle)
            .background(.purple)
    }
}

#if canImport(AppKit)
@MainActor
@Suite("AppKit Tests")
struct UIKitTests {
    @Test func heicConversion() async throws {
        let size = CGSize(width: 300, height: 100)
        let data = ViewToImage.heic(TestView(), size: size)
        
        #expect(data != nil)
        #expect(NSImage(data: data!) != nil)
    }
    
    @Test func jpegConversion() async throws {
        let size = CGSize(width: 300, height: 100)
        let jpegData = ViewToImage.jpeg(TestView(), size: size)
        
        #expect(jpegData != nil)
        #expect(NSImage(data: jpegData!) != nil)
    }
    
    @Test func pngConversion() async throws {
        let size = CGSize(width: 300, height: 100)
        let data = ViewToImage.png(TestView(), size: size)
        
        #expect(data != nil)
        #expect(NSImage(data: data!) != nil)
    }
}
#endif

#if canImport(UIKit)
@MainActor
@Suite("UIKit Tests")
struct UIKitTests {
    @Test func heicConversion() async throws {
        let size = CGSize(width: 300, height: 100)
        let data = ViewToImage.heic(TestView(), size: size)
        
        #expect(data != nil)
        #expect(UIImage(data: data!) != nil)
    }
    
    @Test func jpegConversion() async throws {
        let size = CGSize(width: 300, height: 100)
        let jpegData = ViewToImage.jpeg(TestView(), size: size)
        
        #expect(jpegData != nil)
        #expect(UIImage(data: jpegData!) != nil)
    }
    
    @Test func pngConversion() async throws {
        let size = CGSize(width: 300, height: 100)
        let data = ViewToImage.png(TestView(), size: size)
        
        #expect(data != nil)
        #expect(UIImage(data: data!) != nil)
    }
}
#endif
