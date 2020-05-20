//
//  RoomService.swift
//
//  Created by Kevin McKee
//  Copyright © 2020 Kevin McKee. All rights reserved.
//

import Foundation
import CoreGraphics

public protocol RoomService {
    
    // Singleton Model
    static var shared: RoomService { get }
    
    // The observable room
    var room: Room { get }
    
    /// The participant joins a room via the context of a specified room
    /// - Parameters:
    ///   - name: The participant name of the room to join
    ///   - completion: The completion block with the joined room or error
    func join(name: String, _ completion: ((Room?, Error?) -> Void)?)
    
    /// The participant leaves the huddle room
    func leave(_ completion: (() -> Void)?)

    /// Sends updates for the user's position
    /// - Parameters:
    ///   - position: The user's x, y position on screen
    func update(_ position: CGPoint)
}
