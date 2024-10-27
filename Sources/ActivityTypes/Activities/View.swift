//
//  View.swift
//  swift-activity-streams
//
//  Created by Jaehong Kang on 10/26/24.
//

public struct View<
    Actor: ObjectProtocol,
    Object: ObjectProtocol
>: ActivityProtocol {
    public static var type: String {
        View<ActivityTypes.Object, ActivityTypes.Object>.type
    }

    public let type: String = Self.type
    public var id: String
    public var name: String

    public var actor: Actor
    public var object: Object
}

extension View<Object, Object> {
    static let type: String = "View"
}

extension View: Equatable where Actor: Equatable, Object: Equatable { }

extension View: Hashable where Actor: Hashable, Object: Hashable { }

extension View: Codable where Actor: Codable, Object: Codable {
    private enum CodingKeys: CodingKey {
        case type
        case id
        case name
        case actor
        case object
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
        self.object = try container.decode(Object.self, forKey: .object)
    }
}