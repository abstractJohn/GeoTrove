//
//  GTLayerSettingsView.swift
//  GeoTrove
//
//  Created by John Nelson on 3/23/24.
//

import SwiftUI
import SwiftData

struct GTLayerSettingsView: View {
    @Environment(\.modelContext) private var modelContext
    @State var layer: Layer
    @State var displayAddSheet = false
    init(layer:Layer) {
        self.layer = layer
    }
    var body: some View {
        NavigationView {
            Form {
                Section(header: HStack{
                    Text("Fields")
                    Spacer()
                    Button {
                        addField()
                    } label: {
                        Image(systemName: "plus")
                            .font(.title2)
                    }}) {
                    NavigationStack{
                        List {
                            ForEach(layer.fields ?? []) {
                                field in
                                NavigationLink(field.name ?? "", value: field)

                            }
                        }
                        .navigationDestination(for: Field.self) { field in
                            GTFieldSettingsView(field: field)
                        }
                    }

                }
            }
            .navigationTitle(layer.wrappedName)
        }
    }
    func addField() {
        let field = Field()
        field.layers?.append(layer)
        modelContext.insert(field)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Layer.self, Field.self, DataFeature.self, configurations: config)
    let layer = Layer(name: "Example", type: .point)
    container.mainContext.insert(layer)
    return GTLayerSettingsView(layer: layer)
        .modelContainer(container)
}
