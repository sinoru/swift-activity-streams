//
//  Delete.swift
//  swift-activity-streams
//
//  Created by Jaehong Kang on 10/26/24.
//

public struct Delete<
    Actor: ObjectProtocol,
    Object: ObjectProtocol,
    Origin: ObjectProtocol
>: ActivityProtocol {
    public static var type: String {
        Delete<ActivityTypes.Object, ActivityTypes.Object, ActivityTypes.Object>.type
    }

    public let type: String = Self.type
    public var id: String
    public var name: String

    public var actor: Actor
    public var object: Object
    public var origin: Origin?
}

extension Delete<Object, Object, Object> {
    static let type: String = "Delete"
}

extension Delete: Equatable where Actor: Equatable, Object: Equatable, Origin: Equatable { }

extension Delete: Hashable where Actor: Hashable, Object: Hashable, Origin: Hashable { }

extension Delete: Codable where Actor: Codable, Object: Codable, Origin: Codable {
    private enum CodingKeys: CodingKey {
        case type
        case id
        case name
        case actor
        case object
        case origin
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
        self.origin = try container.decode(Origin.self, forKey: .origin)
    }
}
