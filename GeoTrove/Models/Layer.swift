//
//  Layer.swift
//  GeoTrove
//
//  Created by John Nelson on 3/14/24.
//

import Foundation
import SwiftData

@Model
final class Layer: Identifiable, Hashable, Codable {
    var id: UUID?
    var name: String?
    var image: String?
    @Relationship(inverse: \Field.layers) var fields: [Field]?
    var type: LayerType?
    var enabled: Bool?
    var features: [DataFeature]?

    // convenience unwrapper
    var wrappedName: String {
        name ?? ""
    }
    var wrappedImage: String {
        image ?? ""
    }


    init(id: UUID? = nil, name: String? = nil, image: String? = nil, fields: [Field]? = nil, type: LayerType? = nil, enabled: Bool? = nil) {
        self.id = id
        self.name = name
        self.image = image
        self.fields = fields
        self.type = type
        self.enabled = enabled
    }

    init(name: String, type: LayerType, image: String) {
        self.id = UUID()
        self.name = name
        self.image = image
        self.type = type
        self.fields = []
        self.features = []
        self.enabled = false
    }

    enum CodingKeys: CodingKey {
        case _id
        case _name
        case _image
        case _fields
        case _type
        case _enabled
    }

    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: ._id)
        self.name = try container.decode(String.self, forKey: ._name)
        self.image = try container.decode(String.self, forKey: ._image)
        self.fields = try container.decode([Field].self, forKey: ._fields)
        self.type = try container.decode(LayerType.self, forKey: ._type)
        self.enabled = try container.decode(Bool.self, forKey: ._enabled)
    }

    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: ._id)
        try container.encode(name, forKey: ._name)
        try container.encode(image, forKey: ._image)
        try container.encode(fields, forKey: ._fields)
        try container.encode(type, forKey: ._type)
        try container.encode(enabled, forKey: ._enabled)
    }
}
