//
//  GTMapView.swift
//  GeoTrove
//
//  Created by John Nelson on 3/17/24.
//

import SwiftUI
import SwiftData
import CoreLocation
import MapKit
import GEOSwift
import GEOSwiftMapKit

struct GTMapView: View {
    @Namespace var mapScope
    private let locationManager = CLLocationManager()
    @Environment(\.modelContext) private var modelContext
    @Query(filter: #Predicate<Layer> {
        layer in
        layer.enabled ?? false
    }) var enabledLayers: [Layer]
    @Query var allLayers: [Layer]
    @State var showLayerPicker = false
    @State private var position = MapCameraPosition.userLocation(fallback: .automatic)
    var body: some View {

        ZStack(alignment: .bottomTrailing) {
            Map (position: $position, scope: mapScope) {
                UserAnnotation()

            }
            .mapScope(mapScope)
            .mapStyle(.hybrid(elevation: .automatic, pointsOfInterest: .all, showsTraffic: true))
            .mapControls {
                MapCompass(scope: mapScope)
                    .mapControlVisibility(.visible)
                MapUserLocationButton(scope: mapScope)
                MapScaleView(anchorEdge: .leading, scope: mapScope)
                    .mapControlVisibility(.visible)
            }
            .onAppear {
                locationManager.requestWhenInUseAuthorization()
            }
            .safeAreaInset(edge:.trailing) {

                Button(action: {
                    showLayerPicker.toggle()
                }) {
                    Image(systemName: "square.3.layers.3d.bottom.filled")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .frame(width: 77.5, height: 77.5)
                        .foregroundColor(Color.primary)
                        .background(Color.secondary)
                        .opacity(0.85)
                        .clipShape(Circle())
                }
            }
            .fullScreenCover(isPresented: $showLayerPicker, onDismiss: {showLayerPicker = false}, content: {
                GTLayerPickerView()
        })
            RadialMenu(title: "Add", closedImage: Image(systemName: "plus.circle"), openImage: Image(systemName: "multiply.circle"), buttons: buttons, animation: .interactiveSpring(response: 0.4, dampingFraction: 0.6))
                .buttonStyle(CustomButtonStyle())
        }
    }
    func add(for layer: Layer) {
        print("Adding for layer \(layer.wrappedName)")
    }
    var buttons: [RadialButton] {
        allLayers.map({layer in
            RadialButton(label: layer.wrappedName, image: Image(systemName: layer.wrappedImage), action:{ add(for: layer)})
        })
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Layer.self, Field.self, DataFeature.self, configurations: config)

    return GTMapView()
        .modelContainer(container)
}
