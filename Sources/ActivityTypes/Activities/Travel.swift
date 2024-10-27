//
//  Travel.swift
//  swift-activity-streams
//
//  Created by Jaehong Kang on 10/26/24.
//

public struct Travel<
    Actor: ObjectProtocol,
    Target: ObjectProtocol,
    Origin: ObjectProtocol
>: IntransitiveActivityProtocol {
    public static var type: String {
        Travel<ActivityTypes.Object, ActivityTypes.Object, ActivityTypes.Object>.type
    }

    public let type: String = Self.type
    public var id: String
    public var name: String

    public var actor: Actor
    public var target: Target?
    public var origin: Origin?
}

extension Travel<Object, Object, Object> {
    static let type: String = "Travel"
}

extension Travel: Equatable where Actor: Equatable, Target: Equatable, Origin: Equatable { }

extension Travel: Hashable where Actor: Hashable, Target: Hashable, Origin: Hashable { }

extension Travel: Codable where Actor: Codable, Target: Codable, Origin: Codable {
    private enum CodingKeys: CodingKey {
        case type
        case id
        case name
        case actor
        case target
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
        self.target = try container.decodeIfPresent(Target.self, forKey: .target)
        self.origin = try container.decodeIfPresent(Origin.self, forKey: .origin)
    }
}
