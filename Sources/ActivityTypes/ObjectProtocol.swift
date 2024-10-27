//
//  ObjectProtocol.swift
//  swift-activity-streams
//
//  Created by Jaehong Kang on 10/26/24.
//

public protocol ObjectProtocol: Sendable {
    var type: String { get }
    var id: String { get }
    var name: String { get }
}
