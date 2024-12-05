//
//  ViewToImage+AppKit.swift
//  ViewToImage
//
//  Created by Kevin Hermawan on 12/4/24.
//

#if canImport(AppKit)
import SwiftUI

/// A structure that provides methods to convert SwiftUI views to different image formats.
public struct ViewToImage: ViewToImageProtocol {
    private static let screenScaleFactor: CGFloat = {
        NSScreen.main?.backingScaleFactor ?? 2.0
    }()
    
    /// Converts a SwiftUI view to HEIC format data.
    /// - Parameters:
    ///   - view: A view to convert.
    ///   - size: The output size of the image.
    ///   - scale: A scale factor to apply to the image. Defaults to 1.0.
    /// - Returns: A HEIC image data if successful, or nil if the conversion fails.
    public static func heic<T: View>(_ view: T, size: CGSize, scale: CGFloat = 1.0) -> Data? {
        createBitmapRep(view, size: size, scale: scale)?
            .heicData()
    }
    
    /// Converts a SwiftUI view to JPEG format data.
    /// - Parameters:
    ///   - view: A view to convert.
    ///   - size: The output size of the image.
    ///   - scale: A scale factor to apply to the image. Defaults to 1.0.
    /// - Returns: A JPEG image data if successful, or nil if the conversion fails.
    public static func jpeg<T: View>(_ view: T, size: CGSize, scale: CGFloat = 1.0) -> Data? {
        createBitmapRep(view, size: size, scale: scale)?
            .representation(using: .jpeg, properties: [.compressionFactor: 1.0])
    }
    
    
    /// Converts a SwiftUI view to PNG format data.
    /// - Parameters:
    ///   - view: A view to convert.
    ///   - size: The output size of the image.
    ///   - scale: A scale factor to apply to the image. Defaults to 1.0.
    /// - Returns: A PNG image data if successful, or nil if the conversion fails.
    public static func png<T: View>(_ view: T, size: CGSize, scale: CGFloat = 1.0) -> Data? {
        createBitmapRep(view, size: size, scale: scale)?
            .representation(using: .png, properties: [:])
    }
}

private extension ViewToImage {
    static func createBitmapRep<T: View>(_ view: T, size: CGSize, scale: CGFloat) -> NSBitmapImageRep? {
        let outputScale = max(scale, 0.1) * screenScaleFactor
        let pixelWidth = Int(size.width * outputScale)
        let pixelHeight = Int(size.height * outputScale)
        
        let hostingView = NSHostingView(rootView: view)
        hostingView.frame = CGRect(origin: .zero, size: size)
        hostingView.wantsLayer = true
        
        hostingView.layer?.drawsAsynchronously = false
        hostingView.layer?.needsDisplayOnBoundsChange = true
        
        if let layer = hostingView.layer {
            configureLayer(layer, scale: outputScale)
        }
        
        hostingView.layoutSubtreeIfNeeded()
        
        guard let bitmapRep = NSBitmapImageRep(
            bitmapDataPlanes: nil,
            pixelsWide: pixelWidth,
            pixelsHigh: pixelHeight,
            bitsPerSample: 8,
            samplesPerPixel: 4,
            hasAlpha: true,
            isPlanar: false,
            colorSpaceName: .deviceRGB,
            bytesPerRow: 0,
            bitsPerPixel: 32
        ) else { return nil }
        
        bitmapRep.size = size
        
        guard let context = NSGraphicsContext(bitmapImageRep: bitmapRep) else { return nil }
        
        NSGraphicsContext.saveGraphicsState()
        NSGraphicsContext.current = context
        
        configureGraphicsContext(context)
        
        hostingView.cacheDisplay(in: hostingView.bounds, to: bitmapRep)
        
        NSGraphicsContext.restoreGraphicsState()
        
        return bitmapRep
    }
    
    static func configureGraphicsContext(_ context: NSGraphicsContext) {
        context.shouldAntialias = false
        context.imageInterpolation = .none
        
        let cgContext = context.cgContext
        cgContext.interpolationQuality = .none
        
        cgContext.setShouldAntialias(false)
        cgContext.setAllowsAntialiasing(false)
        cgContext.setAllowsFontSmoothing(true)
        cgContext.setAllowsFontSubpixelPositioning(true)
        cgContext.setAllowsFontSubpixelQuantization(true)
    }
    
    static func configureLayer(_ layer: CALayer, scale: CGFloat) {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        layer.contentsScale = scale
        layer.rasterizationScale = scale
        layer.masksToBounds = true
        layer.shouldRasterize = true
        layer.drawsAsynchronously = false
        
        layer.minificationFilter = .nearest
        layer.magnificationFilter = .nearest
        
        layer.shouldRasterize = true
        layer.rasterizationScale = scale
        layer.allowsEdgeAntialiasing = false
        
        CATransaction.commit()
    }
}
#endif
