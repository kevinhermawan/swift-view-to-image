//
//  PreferencesManager.swift
//  Playground
//
//  Created by Kevin Hermawan on 12/4/24.
//

import SwiftUI
import ViewToImage
import UniformTypeIdentifiers

@MainActor
@Observable
final class PreferencesManager {
    var imageToExport: ImageDocument?
    
    var availableImageTypes: [UTType] = [.heic, .jpeg, .png]
    var imageType: UTType = .png
    
    var imageWidth: CGFloat = 256
    var imageHeight: CGFloat = 128
    
    func export<T: View>(view: T) {
        let size = CGSize(width: imageWidth, height: imageHeight)
        
        if let imageData = ViewToImage.png(view, size: size) {
            self.imageToExport = ImageDocument(imageData: imageData)
        }
    }
}

struct ImageDocument: FileDocument {
    static var readableContentTypes: [UTType] = [.heic, .jpeg, .png]
    
    var imageData: Data
    
    init(imageData: Data) {
        self.imageData = imageData
    }
    
    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents else {
            throw CocoaError(.fileReadCorruptFile)
        }
        
        self.imageData = data
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        FileWrapper(regularFileWithContents: imageData)
    }
}
