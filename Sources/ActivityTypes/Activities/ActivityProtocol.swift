//
//  ActivityProtocol.swift
//  swift-activity-streams
//
//  Created by Jaehong Kang on 10/26/24.
//

public protocol ActivityProtocol<Object>: IntransitiveActivityProtocol {
    associatedtype Object: ObjectProtocol

    var object: Object { get }
}
