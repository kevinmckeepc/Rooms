import Foundation
import CoreGraphics

/// Provides the basic APIs to join, leave and interact inside a `Room`. This class acts as a proxy to
/// the underlying `RoomService` to abstract away any implementation details.
public class Rooms {
    
    private static let service: RoomService = SocketRoomService.shared
    
    /// The observable room
    public static var room: Room {
        return service.room
    }
    
    // MARK: Room

    /// The participant joins a room via the context of a specified room
    /// - Parameters:
    ///   - name: The participant name
    ///   - completion: The completion block with the joined room or error
    public static func join(name: String, _ completion: ((Room?, Error?) -> Void)?) {
        service.join(name: name, completion)
    }
    
    /// The participant leaves the room
    public static func leave(_ completion: (() -> Void)?) {
        service.leave(completion)
    }

    // MARK: Positition

    /// Sends updates for the user's position
    /// - Parameters:
    ///   - position: The user's x, y position on screen
    public static func update(_ position: CGPoint) {
        service.update(position)
    }
}
