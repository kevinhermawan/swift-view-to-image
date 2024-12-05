//
//  PlaygroundApp.swift
//  Playground
//
//  Created by Kevin Hermawan on 12/4/24.
//

import SwiftUI

@main
struct PlaygroundApp: App {
    @State private var preferencesManager = PreferencesManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(preferencesManager)
        }
    }
}
