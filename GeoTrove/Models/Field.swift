//
//  Field.swift
//  GeoTrove
//
//  Created by John Nelson on 3/14/24.
//

import Foundation
import SwiftData
import SwiftUI

@Model
final class Field: Identifiable, Hashable, Codable {
    var id: UUID?
    var name: String?
    var layers: [Layer]?
    var type: FieldType?

    init(id: UUID? = nil, name: String? = nil, layers: [Layer]? = nil, type: FieldType? = nil) {
        self.id = id
        self.name = name
        self.layers = layers
        self.type = type
    }


    enum CodingKeys: CodingKey {
        case _id
        case _name
        case _layers
        case _type
    }

    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: ._id)
        self.name = try container.decode(String.self, forKey: ._name)
        self.layers = try container.decode([Layer].self, forKey: ._layers)
        self.type = try container.decode(FieldType.self, forKey: ._type)
    }

    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: ._id)
        try container.encode(name, forKey: ._name)
        try container.encode(layers, forKey: ._layers)
        try container.encode(type, forKey: ._type)
    }
}

enum FieldType: String, Equatable, CaseIterable, Codable {
    case number = "Number"
    case boolean = "Boolean"
    case list = "List"
    case string = "Text"
    case document = "Document or Photo"
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
}
