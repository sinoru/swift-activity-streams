//
//  Offer.swift
//  swift-activity-streams
//
//  Created by Jaehong Kang on 10/26/24.
//

public protocol OfferProtocol: ActivityProtocol { }

public struct Offer<
    Actor: ObjectProtocol,
    Object: ObjectProtocol,
    Target: ObjectProtocol
>: OfferProtocol {
    public static var type: String {
        Offer<ActivityTypes.Object, ActivityTypes.Object, ActivityTypes.Object>.type
    }

    public let type: String = Self.type
    public var id: String
    public var name: String

    public var actor: Actor
    public var object: Object
    public var target: Target?
}

extension Offer<Object, Object, Object> {
    static let type: String = "Offer"
}

extension Offer: Equatable where Actor: Equatable, Object: Equatable, Target: Equatable { }

extension Offer: Hashable where Actor: Hashable, Object: Hashable, Target: Hashable { }

extension Offer: Codable where Actor: Codable, Object: Codable, Target: Codable {
    private enum CodingKeys: CodingKey {
        case type
        case id
        case name
        case actor
        case object
        case target
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
        self.target = try container.decode(Target.self, forKey: .target)
    }
}
