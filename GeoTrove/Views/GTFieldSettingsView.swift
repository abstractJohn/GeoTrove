//
//  GTFieldSettingsView.swift
//  GeoTrove
//
//  Created by John Nelson on 3/23/24.
//

import SwiftUI
import SwiftData

struct GTFieldSettingsView: View {
    @State var field: Field
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Layer.self, Field.self, DataFeature.self, configurations: config)
    let field = Field(name: "Example", type: .number)
    container.mainContext.insert(field)
    return GTFieldSettingsView(field: field)
}
