//
//  GTLayerSettingsView.swift
//  GeoTrove
//
//  Created by John Nelson on 3/23/24.
//

import SwiftUI
import SwiftData
import AQUI

struct GTLayerSettingsView: View {
    @Environment(\.modelContext) private var modelContext
    @State var layer: Layer
    @State var displayAddSheet = false
    @State var showingImages = false
    init(layer:Layer) {
        self.layer = layer
    }
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Layer Name", text: Binding($layer.name, "New Layer"))
                        .submitLabel(.done)
                    Picker("Layer Type", selection: Binding($layer.type, .point)) {
                        ForEach(LayerType.allCases, id: \.self) {value in
                            Text(value.localizedName)
                                .tag(value)
                        }
                    }
                    Button {
                        showingImages = true
                    } label: {
                        HStack {
                            Text("Choose an Image")
                            Spacer()
                            Image(systemName: layer.image ?? "multiply.circle")
                                .font(.title)
                        }
                    }.systemImagePicker(isPresented: $showingImages, selection: $layer.image)
                }
                Section(header: HStack{
                    Text("Fields")
                    Spacer()
                    Button {
                        addField()
                    } label: {
                        Image(systemName: "plus")
                            .font(.title2)
                    }}) {
                        List {
                            ForEach(layer.fields ?? []) {
                                field in
                                NavigationLink(field.name ?? "") {
                                    GTFieldSettingsView(field: field)
                                }

                            }
                        }
                    }

            }
            .navigationTitle(layer.wrappedName)
        }
    }
    func addField() {
        let field = Field()
        layer.fields?.append(field)
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
