//
//  ContentView.swift
//  Playground
//
//  Created by Kevin Hermawan on 12/4/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(PreferencesManager.self) private var preferencesManager
    
    @AppStorage("text") private var text: String = "🦄🦄🦄"
    
    @State private var isFileExporterPresented = false
    @State private var isPreferencesPresented = false
    
    var body: some View {
        NavigationStack {
            unicornView
                .toolbar {
                    ToolbarItemGroup(placement: .primaryAction) {
                        Button("Preferences", systemImage: "gearshape", action: { isPreferencesPresented.toggle() })
                        
                        Button("Export", systemImage: "square.and.arrow.up") {
                            preferencesManager.export(view: unicornView)
                            isFileExporterPresented.toggle()
                        }
                    }
                }
                .inspector(isPresented: $isPreferencesPresented) {
                    PreferencesView()
                }
                .fileExporter(
                    isPresented: $isFileExporterPresented,
                    document: preferencesManager.imageToExport,
                    contentType: preferencesManager.imageType
                ) { result in
                    switch result {
                    case .success(let url):
                        print("Saved to \(url)")
                    case .failure(let error):
                        print("Error: \(error.localizedDescription)")
                    }
                }
        }
    }
    
    private var unicornView: some View {
        VStack {
            TextField("", text: $text)
                .textFieldStyle(.plain)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .frame(width: preferencesManager.imageWidth, height: preferencesManager.imageHeight)
        .background(
            LinearGradient(
                colors: [.purple, .pink],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
    }
}
