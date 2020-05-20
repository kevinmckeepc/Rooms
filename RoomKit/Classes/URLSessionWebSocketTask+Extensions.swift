//
//  URLSessionWebSocketTask+Extensions.swift
//  RoomKit
//
//  Created by Kevin McKee on 5/20/20.
//  Copyright © 2020 Kevin McKee. All rights reserved.
//

import Foundation

extension URLSessionWebSocketTask.Message {
    
    static func encode<T: Codable>(_ object: T?, encoder: JSONEncoder) -> URLSessionWebSocketTask.Message {
        
        guard let object = object, let data = try? encoder.encode(object) else {
            debugPrint("Unable to encode data")
            return URLSessionWebSocketTask.Message.string("")
        }
        return URLSessionWebSocketTask.Message.data(data)
    }
}
