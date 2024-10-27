//
//  IntransitiveActivity.swift
//  swift-activity-streams
//
//  Created by Jaehong Kang on 10/26/24.
//

public struct IntransitiveActivity<
    Actor: ObjectProtocol
>: IntransitiveActivityProtocol {
    public static var type: String {
        IntransitiveActivity<ActivityTypes.Object>.type
    }

    public let type: String = Self.type
    public var id: String
    public var name: String

    public var actor: Actor
}

extension IntransitiveActivity<Object> {
    static let type: String = "IntransitiveActivity"
}

extension IntransitiveActivity: Equatable where Actor: Equatable { }

extension IntransitiveActivity: Hashable where Actor: Hashable { }

extension IntransitiveActivity: Codable where Actor: Codable {
    private enum CodingKeys: CodingKey {
        case type
        case id
        case name
        case actor
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
    }
}
