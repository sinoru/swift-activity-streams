//
//  Object.swift
//  swift-activity-streams
//
//  Created by Jaehong Kang on 10/26/24.
//

public struct Object: ObjectProtocol, Codable {
    public static let type = "Object"

    public var type: String
    public var id: String
    public var name: String

    public init(type: String, id: String, name: String) {
        self.type = type
        self.id = id
        self.name = name
    }

    public init(id: String, name: String) {
        self.init(type: Self.type, id: id, name: name)
    }
}
