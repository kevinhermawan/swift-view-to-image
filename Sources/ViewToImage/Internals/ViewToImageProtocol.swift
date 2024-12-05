//
//  ViewToImageProtocol.swift
//  ViewToImage
//
//  Created by Kevin Hermawan on 12/5/24.
//

import SwiftUI

@MainActor
protocol ViewToImageProtocol {
    static func heic<T: View>(_ view: T, size: CGSize, scale: CGFloat) -> Data?
    static func jpeg<T: View>(_ view: T, size: CGSize, scale: CGFloat) -> Data?
    static func png<T: View>(_ view: T, size: CGSize, scale: CGFloat) -> Data?
}

extension ViewToImageProtocol {
    static func heic<T: View>(_ view: T, size: CGSize, scale: CGFloat = 1.0) -> Data? {
        heic(view, size: size, scale: scale)
    }
    
    static func jpeg<T: View>(_ view: T, size: CGSize, scale: CGFloat = 1.0) -> Data? {
        jpeg(view, size: size, scale: scale)
    }
    
    static func png<T: View>(_ view: T, size: CGSize, scale: CGFloat = 1.0) -> Data? {
        png(view, size: size, scale: scale)
    }
}
