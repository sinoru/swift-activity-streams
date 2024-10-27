//
//  Arrive.swift
//  swift-activity-streams
//
//  Created by Jaehong Kang on 10/26/24.
//

public struct Arrive<
    Actor: ObjectProtocol,
    Location: ObjectProtocol,
    Origin: ObjectProtocol
>: IntransitiveActivityProtocol {
    public static var type: String {
        Arrive<ActivityTypes.Object, ActivityTypes.Object, ActivityTypes.Object>.type
    }

    public let type: String = Self.type
    public var id: String
    public var name: String

    public var actor: Actor
    public var location: Location
    public var origin: Origin
}

extension Arrive<Object, Object, Object> {
    static let type: String = "Arrive"
}

extension Arrive: Equatable where Actor: Equatable, Location: Equatable, Origin: Equatable { }

extension Arrive: Hashable where Actor: Hashable, Location: Hashable, Origin: Hashable { }

extension Arrive: Codable where Actor: Codable, Location: Codable, Origin: Codable {
    private enum CodingKeys: CodingKey {
        case type
        case id
        case name
        case actor
        case location
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
        self.location = try container.decode(Location.self, forKey: .location)
        self.origin = try container.decode(Origin.self, forKey: .origin)
    }
}
