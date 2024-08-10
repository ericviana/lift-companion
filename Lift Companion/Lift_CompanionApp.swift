//
//  Lift_CompanionApp.swift
//  Lift Companion
//
//  Created by Eric on 13/07/24.
//

import SwiftUI

@main
struct Lift_CompanionApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Log.self])
    }
}
