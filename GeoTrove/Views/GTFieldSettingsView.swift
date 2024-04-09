//
//  GTFieldSettingsView.swift
//  GeoTrove
//
//  Created by John Nelson on 3/23/24.
//

import SwiftUI
import SwiftData
import AQUI

struct GTFieldSettingsView: View {
    @State var field: Field
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: Binding($field.name, "New Field"))
                Picker("Field Type", selection: Binding($field.type, .string)) {
                    ForEach(FieldType.allCases, id: \.self) {value in
                        Text(value.localizedName)
                            .tag(value)
                    }
                }
            }
            .navigationTitle(Binding($field.name, "New Field"))
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Layer.self, Field.self, DataFeature.self, configurations: config)
    let field = Field(name: "Example", type: .number)
    container.mainContext.insert(field)
    return GTFieldSettingsView(field: field)
}
