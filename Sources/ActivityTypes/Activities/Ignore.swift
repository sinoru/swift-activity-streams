//
//  Ignore.swift
//  swift-activity-streams
//
//  Created by Jaehong Kang on 10/26/24.
//

public protocol IgnoreProtocol: ActivityProtocol {
    
}

public struct Ignore<
    Actor: ObjectProtocol,
    Object: ObjectProtocol
>: IgnoreProtocol {
    public static var type: String {
        Ignore<ActivityTypes.Object, ActivityTypes.Object>.type
    }

    public let type: String = Self.type
    public var id: String
    public var name: String

    public var actor: Actor
    public var object: Object
}

extension Ignore<Object, Object> {
    static let type: String = "Ignore"
}

extension Ignore: Equatable where Actor: Equatable, Object: Equatable { }

extension Ignore: Hashable where Actor: Hashable, Object: Hashable { }

extension Ignore: Codable where Actor: Codable, Object: Codable {
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
