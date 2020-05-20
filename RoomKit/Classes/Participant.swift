//
//  Participant.swift
//
//  Created by Kevin McKee
//  Copyright © 2020 Kevin McKee. All rights reserved.
//

import Foundation
import CoreGraphics
import Combine

/// Represents the concept of a `Participant` inside a chat room
public struct Participant: Identifiable, Codable {

    enum CodingKeys: String, CodingKey {
        case uid
        case name
        case x
        case y
    }
        
    public var uid: String = ""
    public var name: String = "Anonymous"
    public var coordinates: CGPoint = .zero
    
    // MARK: Identifiable
    
    // Use the uid as our identifier
    public var id: String { uid }


    // Convenience var indicating if the user is me or not
    public var isMe: Bool {
        return false
    }
    
    // Convenience initializer
    public init(name: String) {
        self.uid = UUID().uuidString
        self.name = name.isEmpty ? "Anonymous" : name
    }
    
    // MARK: Codable
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        uid = try container.decode(String.self, forKey: .uid)
        name = try container.decode(String.self, forKey: .name)
        let x = try container.decode(Float.self, forKey: .x)
        let y = try container.decode(Float.self, forKey: .y)
        coordinates = CGPoint(x: CGFloat(x), y: CGFloat(y))
    }
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(uid, forKey: .uid)
        try container.encode(name, forKey: .name)
        try container.encode(Int(coordinates.x), forKey: .x)
        try container.encode(Int(coordinates.y), forKey: .y)
    }
}
