//
//  LifecycleTestAppApp.swift
//  LifecycleTestApp
//
//  Created by Sajid Shanta on 5/2/25.
//

import SwiftUI

@main
struct LifecycleTestAppApp: App {
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .onChange(of: scenePhase) { oldPhase, newPhase in
            print("from \(oldPhase), App is moving to -> \(newPhase)\n")
        }
    }
}
