//
//  GTSettingsView.swift
//  GeoTrove
//
//  Created by John Nelson on 3/17/24.
//

import SwiftUI
import SwiftData

struct GTSettingsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var layers: [Layer]
    @State var name: String = ""
    @State var displayAddSheet = false
    var body: some View {
        NavigationView {
            Form {
                Section("User") {
                    TextField("Name", text: $name)
                                            .onSubmit {
                                                UserDefaults.standard.setValue(name, forKey: "User Name")
                                            }
                                            .submitLabel(.done)
                }
                Section(header: HStack {
                                    Text("Layers")
                                    Spacer()
                                    Button {
                                        displayAddSheet = true
                                    } label: {
                                        Image(systemName: "plus")
                                            .font(.body)
                                    }
                                }) {
                    List {
                        ForEach(layers) {
                            layer in
                            Text(layer.name ?? "")
                        }
                        .onDelete(perform: deleteLayer)

                    }
                }
            }
            .navigationTitle("Settings")
        }
        .fullScreenCover(isPresented: $displayAddSheet, onDismiss: {
                    displayAddSheet = false
                }, content:{ AddLayerView {
                    newName, newType in
                    addLayer(name: newName, type: newType)
                    displayAddSheet = false
                }})
    }

    private func addLayer(name: String, type: LayerType) -> Void {
            withAnimation {
                let newLayer = Layer(name: name, type: type)
                modelContext.insert(newLayer)
            }
        }

    private func deleteLayer(offsets: IndexSet) {
        offsets.forEach { offset in
            modelContext.delete(layers[offset])
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Layer.self, Field.self, DataFeature.self, configurations: config)
    return GTSettingsView()
        .modelContainer(container)
}
