//
//  Question.swift
//  swift-activity-streams
//
//  Created by Jaehong Kang on 10/26/24.
//

public struct Question<
    Actor: ObjectProtocol,
    Element: ObjectProtocol
>: IntransitiveActivityProtocol {
    public static var type: String {
        Question<ActivityTypes.Object, ActivityTypes.Object>.type
    }

    public let type: String = Self.type
    public var id: String
    public var name: String

    public var actor: Actor
    public var oneOf: [Element]?
    public var anyOf: [Element]?
}

extension Question<Object, Object> {
    static let type: String = "Question"
}

extension Question: Codable where Actor: Codable, Element: Codable {
    private enum CodingKeys: CodingKey {
        case type
        case id
        case name
        case actor
        case oneOf
        case anyOf
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)
        guard type != self.type else {
            throw DecodingError.dataCorrupted(.init(codingPath: container.codingPath, debugDescription: "\(type) should be \(self.type)"))
        }

        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.actor = try container.decode(Actor.self, forKey: .actor)
        self.oneOf = try container.decodeIfPresent([Element].self, forKey: .oneOf)
        self.anyOf = try container.decodeIfPresent([Element].self, forKey: .anyOf)
    }
}
