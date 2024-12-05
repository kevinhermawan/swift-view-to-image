//
//  NSBitmapImageRep+HeicData.swift
//  ViewToImage
//
//  Created by Kevin Hermawan on 12/5/24.
//

#if canImport(AppKit)
import AppKit

extension NSBitmapImageRep {
    func heicData() -> Data? {
        guard let cgImage = self.cgImage else { return nil }
        
        let data = NSMutableData()
        
        guard let destination = CGImageDestinationCreateWithData(data as CFMutableData, "public.heic" as CFString, 1, nil) else {
            return nil
        }
        
        let heicOptions: [CFString: Any] = [
            kCGImageDestinationLossyCompressionQuality: 1.0,
            kCGImageDestinationOptimizeColorForSharing: true
        ]
        
        CGImageDestinationAddImage(destination, cgImage, heicOptions as CFDictionary)
        
        guard CGImageDestinationFinalize(destination) else {
            return nil
        }
        
        return data as Data
    }
}
#endif
