//
//  Room.swift
//
//  Created by Kevin McKee
//  Copyright © 2020 Kevin McKee. All rights reserved.
//

import Foundation
import Combine

// An observable room to watch
public class Room: ObservableObject {
    
    @Published
    public var participants = [Participant]()
    
    @Published
    public var isConnected: Bool = false
    
    public init() { }
    
    // Clears out room state information
    func clear() {
        participants.removeAll()
    }
}
