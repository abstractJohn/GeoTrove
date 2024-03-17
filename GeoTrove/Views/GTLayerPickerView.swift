//
//  LayerPickerView.swift
//  GeoTrove
//
//  Created by John Nelson on 3/17/24.
//

import SwiftUI
import SwiftData
struct GTLayerPickerView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) private var modelContext
    @Query var layers: [Layer]
    var body: some View {
        NavigationView {
            List {
                ForEach(layers) {
                    layer in
                    @Bindable var layer = layer
                    if let isOn = Binding<Bool>($layer.enabled) {
                        Toggle(isOn: isOn) {
                            Text(layer.name ?? "")
                        }
                    }
                }
            }
            .toolbar() {
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    Button("Close") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .foregroundColor(.primary)
                })
            }
            .navigationTitle("Visible Layers")
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Layer.self, Field.self, DataFeature.self, configurations: config)

    return GTLayerPickerView()
        .modelContainer(container)
}
