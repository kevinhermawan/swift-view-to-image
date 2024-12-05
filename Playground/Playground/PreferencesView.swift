//
//  PreferencesView.swift
//  Playground
//
//  Created by Kevin Hermawan on 12/4/24.
//

import SwiftUI

struct PreferencesView: View {
    @Environment(PreferencesManager.self) private var preferencesManager
    
    private var imageWidth: String {
        #if canImport(AppKit)
        (preferencesManager.imageWidth * (NSScreen.main?.backingScaleFactor ?? 2.0)).formatted()
        #else
        (preferencesManager.imageWidth * UIScreen.main.scale).formatted()
        #endif
    }
    
    private var imageHeight: String {
        #if canImport(AppKit)
        (preferencesManager.imageHeight * (NSScreen.main?.backingScaleFactor ?? 2.0)).formatted()
        #else
        (preferencesManager.imageHeight * UIScreen.main.scale).formatted()
        #endif
    }
    
    var body: some View {
        @Bindable var preferencesManagerBindable = preferencesManager
        
        Form {
            Section {
                Stepper("Width (\(imageWidth)px)", value: $preferencesManagerBindable.imageWidth, step: 32)
                Stepper("Height (\(imageHeight)px)", value: $preferencesManagerBindable.imageHeight, step: 32)
            }
            
            Section {
                Picker("Export As", selection: $preferencesManagerBindable.imageType) {
                    ForEach(preferencesManager.availableImageTypes, id: \.identifier) { type in
                        Text(type.preferredFilenameExtension?.uppercased() ?? "")
                            .tag(type)
                    }
                }
            }
        }
    }
}
