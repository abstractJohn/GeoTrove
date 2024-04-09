//
//  ContentView.swift
//  GeoTrove
//
//  Created by John Nelson on 3/17/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        TabView {
            GTSettingsView()
                .tabItem { Label("Settings", systemImage: "gearshape.fill") }
            
            GTMapView()
                .tabItem { Label("Map", systemImage: "map.circle") }
            Text("Data List")
                .tabItem { Label("Data", systemImage: "list.bullet.clipboard") }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Layer.self, Field.self, DataFeature.self, configurations: config)
    return ContentView()
        .modelContainer(container)
}
