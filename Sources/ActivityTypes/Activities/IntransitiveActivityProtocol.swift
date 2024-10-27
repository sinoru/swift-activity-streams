//
//  IntransitiveActivityProtocol.swift
//  swift-activity-streams
//
//  Created by Jaehong Kang on 10/26/24.
//

public protocol IntransitiveActivityProtocol: ObjectProtocol {
    associatedtype Actor: ObjectProtocol

    var actor: Actor { get }
}
