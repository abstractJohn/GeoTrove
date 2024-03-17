//
//  AddLayerView.swift
//  GeoTrove
//
//  Created by John Nelson on 3/17/24.
//

import SwiftUI

struct AddLayerView: View {
    @Environment(\.presentationMode) var presentationMode
        @State private var name: String = ""
    @State private var type: LayerType = .point
        let onComplete: (String, LayerType) -> Void
        var body: some View {
            NavigationView {
                Form {
                    Section {
                        TextField("Layer Name", text: $name)
                            .submitLabel(.done)
                        Picker("Layer Type", selection: $type) {
                            ForEach(LayerType.allCases, id: \.self) {value in
                                Text(value.localizedName)
                                    .tag(value)
                            }
                        }
                        Button {
                            onComplete(name,type)
                        } label: {
                            Text("Add Layer")
                        }
                    }
                }
                .toolbar() {
                    ToolbarItem(placement: .navigationBarTrailing, content: {
                        Button("Cancel") {
                            presentationMode.wrappedValue.dismiss()
                        }
                        .foregroundColor(.red)
                    })
                }
                .navigationTitle("Add Layer")
            }
        }

}

#Preview {
    AddLayerView() {
        name, type  in
    }
}
