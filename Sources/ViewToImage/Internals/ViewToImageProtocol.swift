//
//  ViewToImageProtocol.swift
//  ViewToImage
//
//  Created by Kevin Hermawan on 12/5/24.
//

import SwiftUI

@MainActor
protocol ViewToImageProtocol {
    static func heic<T: View>(from view: T, size: CGSize, scale: CGFloat) -> Data?
    static func jpeg<T: View>(from view: T, size: CGSize, scale: CGFloat) -> Data?
    static func png<T: View>(from view: T, size: CGSize, scale: CGFloat) -> Data?
}

extension ViewToImageProtocol {
    static func heic<T: View>(from view: T, size: CGSize, scale: CGFloat = 1.0) -> Data? {
        heic(from: view, size: size, scale: scale)
    }
    
    static func jpeg<T: View>(from view: T, size: CGSize, scale: CGFloat = 1.0) -> Data? {
        jpeg(from: view, size: size, scale: scale)
    }
    
    static func png<T: View>(from view: T, size: CGSize, scale: CGFloat = 1.0) -> Data? {
        png(from: view, size: size, scale: scale)
    }
}
