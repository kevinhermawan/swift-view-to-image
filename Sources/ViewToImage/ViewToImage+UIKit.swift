//
//  ViewToImage+UIKit.swift
//  ViewToImage
//
//  Created by Kevin Hermawan on 12/4/24.
//

#if canImport(UIKit)
import SwiftUI

/// A structure that provides methods to convert SwiftUI views to different image formats.
public struct ViewToImage: ViewToImageProtocol {
    private static let screenScaleFactor: CGFloat = UIScreen.main.scale
    
    /// Converts a SwiftUI view to HEIC format data.
    /// - Parameters:
    ///   - view: A view to convert.
    ///   - size: The output size of the image.
    ///   - scale: A scale factor to apply to the image. Defaults to 1.0.
    /// - Returns: A HEIC image data if successful, or nil if the conversion fails.
    public static func heic<T: View>(from view: T, size: CGSize, scale: CGFloat = 1.0) -> Data? {
        createImage(from: view, size: size, scale: scale)?
            .heicData()
    }
    
    /// Converts a SwiftUI view to JPEG format data.
    /// - Parameters:
    ///   - view: A view to convert.
    ///   - size: The output size of the image.
    ///   - scale: A scale factor to apply to the image. Defaults to 1.0.
    /// - Returns: A JPEG image data if successful, or nil if the conversion fails.
    public static func jpeg<T: View>(from view: T, size: CGSize, scale: CGFloat = 1.0) -> Data? {
        createImage(from: view, size: size, scale: scale)?
            .jpegData(compressionQuality: 1.0)
    }
    
    
    /// Converts a SwiftUI view to PNG format data.
    /// - Parameters:
    ///   - view: A view to convert.
    ///   - size: The output size of the image.
    ///   - scale: A scale factor to apply to the image. Defaults to 1.0.
    /// - Returns: A PNG image data if successful, or nil if the conversion fails.
    public static func png<T: View>(from view: T, size: CGSize, scale: CGFloat = 1.0) -> Data? {
        createImage(from: view, size: size, scale: scale)?
            .pngData()
    }
}

private extension ViewToImage {
    static func createImage<T: View>(from view: T, size: CGSize, scale: CGFloat) -> UIImage? {
        let outputScale = max(scale, 0.1) * screenScaleFactor
        let pixelWidth = Int(size.width * outputScale)
        let pixelHeight = Int(size.height * outputScale)
        let scaledSize = CGSize(width: pixelWidth, height: pixelHeight)
        
        let hostingController = UIHostingController(rootView: view.ignoresSafeArea())
        hostingController.view.frame = CGRect(origin: .zero, size: size)
        hostingController.view.bounds = CGRect(origin: .zero, size: size)
        
        hostingController.view.layer.drawsAsynchronously = false
        hostingController.view.layer.needsDisplayOnBoundsChange = true
        
        configureLayer(hostingController.view.layer, scale: outputScale)
        hostingController.view.layoutIfNeeded()
        
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1.0
        format.opaque = false
        format.preferredRange = .standard
        
        let renderer = UIGraphicsImageRenderer(size: scaledSize, format: format)
        
        return renderer.image { context in
            configureGraphicsContext(context.cgContext)
            context.cgContext.scaleBy(x: outputScale, y: outputScale)
            hostingController.view.drawHierarchy(in: CGRect(origin: .zero, size: size), afterScreenUpdates: true)
        }
    }
    
    static func configureGraphicsContext(_ context: CGContext) {
        context.interpolationQuality = .none
        context.setShouldAntialias(false)
        context.setAllowsAntialiasing(false)
        context.setAllowsFontSmoothing(true)
        context.setAllowsFontSubpixelPositioning(true)
        context.setAllowsFontSubpixelQuantization(true)
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
