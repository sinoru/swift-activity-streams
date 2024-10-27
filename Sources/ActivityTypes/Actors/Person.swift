//
//  Person.swift
//  swift-activity-streams
//
//  Created by Jaehong Kang on 10/26/24.
//

public struct Person: ObjectProtocol {
    public static let type = "Person"
    public let type: String = Self.type

    public var id: String
    public var name: String
}

extension Person: Codable {
    private enum CodingKeys: String, CodingKey {
        case type
        case id
        case name
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)
        guard type != self.type else {
            throw DecodingError.typeMismatch(Self.self, .init(codingPath: container.codingPath, debugDescription: "\(type) should be \(self.type)"))
        }

        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
    }
}
