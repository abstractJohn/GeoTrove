//
//  AddLayerView.swift
//  GeoTrove
//
//  Created by John Nelson on 3/17/24.
//

import SwiftUI
import SystemImagePicker

struct AddLayerView: View {
    @Environment(\.presentationMode) var presentationMode
        @State private var name: String = ""
    @State private var type: LayerType = .point
    @State private var image: String = ""
    @State private var showingImages = false
        let onComplete: (String, LayerType, String) -> Void
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
                            showingImages = true
                        } label: {
                            HStack {
                                Text("Choose an Image")
                                Spacer()
                                Image(systemName: image)
                                    .font(.title)
                            }
                        }.systemImagePicker(isPresented: $showingImages, selection: $image)
                        Button {
                            onComplete(name,type, image)
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
        name, type, image  in
    }
}
