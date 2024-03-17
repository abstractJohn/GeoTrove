//
//  GeoTroveApp.swift
//  GeoTrove
//
//  Created by John Nelson on 3/17/24.
//

import SwiftUI
import SwiftData

@main
struct GeoTroveApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Layer.self, Field.self, DataFeature.self])
    }
}
