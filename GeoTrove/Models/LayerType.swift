//
//  LayerType.swift
//  GeoTrove
//
//  Created by John Nelson on 3/17/24.
//

import Foundation
import SwiftUI

enum LayerType: String, Equatable, CaseIterable, Codable {
    case point = "Point"
    case line = "Line"
    case polygon = "Polygon"
    case multipoint = "Multi-point"
    case multiline = "Multi-line"
    case multipolygon = "Multi-polygon"

    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
}
