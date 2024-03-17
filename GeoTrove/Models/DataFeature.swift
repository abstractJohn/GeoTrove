//
//  DataFeature.swift
//  GeoTrove
//
//  Created by John Nelson on 3/17/24.
//

import Foundation
import SwiftData
import GEOSwift
@Model
final class DataFeature: Identifiable, Hashable, Codable {
    var id: UUID?
    var foreignUniqueId: String?
    var changeTime: Date?
    var layer: Layer?
    var feature: Feature?

    init(id: UUID? = nil, foreignUniqueId: String? = nil, changeTime: Date? = nil, layer: Layer? = nil, feature: Feature? = nil) {
        self.id = id
        self.foreignUniqueId = foreignUniqueId
        self.changeTime = changeTime
        self.layer = layer
        self.feature = feature
    }

    enum CodingKeys: CodingKey {
        case _id
        case _foreignUniqueId
        case _changeTime
        case _layer
        case _feature
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: ._id)
        self.foreignUniqueId = try container.decode(String.self, forKey: ._foreignUniqueId)
        self.changeTime = try container.decode(Date.self, forKey: ._changeTime)
        self.layer = try container.decode(Layer.self, forKey: ._layer)
        self.feature = try container.decode(Feature.self, forKey: ._feature)
    }

    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: ._id)
        try container.encode(foreignUniqueId, forKey: ._foreignUniqueId)
        try container.encode(changeTime, forKey: ._changeTime)
        try container.encode(layer, forKey: ._layer)
        try container.encode(feature, forKey: ._feature)
    }

    static func == (lhs: DataFeature, rhs: DataFeature) -> Bool {
        (lhs.id == rhs.id) || (lhs.foreignUniqueId == rhs.foreignUniqueId)
    }
}
