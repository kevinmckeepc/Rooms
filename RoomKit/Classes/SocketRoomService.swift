import Foundation
import CoreGraphics
import AudioToolbox

class SocketRoomService: NSObject, RoomService {

    static var shared: RoomService = SocketRoomService()

    // Current room
    internal var room = Room()
    
    // WebSocket
    private var urlSession: URLSession!
    private var webSocketTask: URLSessionWebSocketTask!
    
    private override init() {
        super.init()
        urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
        webSocketTask = urlSession.webSocketTask(with: URL(string: "ws://0.0.0.0:8080/ws")!)
        webSocketTask.resume()
    }
        
    // Internal
    private var me = Participant(name: "Anonymous")
    
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    func join(name: String, _ completion: ((Room?, Error?) -> Void)?) {
        debugPrint("\(name) is joining the room!")
        me = Participant(name: name)
        connect(completion)
    }
    
    func leave(_ completion: (() -> Void)?) {
        webSocketTask.cancel(with: .goingAway, reason: nil)
        room.isConnected = false
        room.clear()
        completion?()
        AudioServicesPlaySystemSound(1152)
    }

    func update(_ position: CGPoint) {
        guard room.isConnected else { return }

        me.coordinates = position
        let encoded = URLSessionWebSocketTask.Message.encode(me, encoder: encoder)
        webSocketTask.send(encoded) { (error) in
            guard error == nil else { return }
            debugPrint("Update sent!")
        }
    }
}

extension SocketRoomService {
    
    private func connect(_ completion: ((Room?, Error?) -> Void)?) {
        
        // Ideally we would use data messages but encoding as a string for now
        let encoded = URLSessionWebSocketTask.Message.encode(me, encoder: encoder)
        
        // Send a message
        webSocketTask.send(encoded) { (error) in
            guard error == nil else { return }
            DispatchQueue.main.async {
                self.room.isConnected = true
                self.room.participants.append(self.me)
                completion?(self.room, nil)
                self.receiveMessage()
                AudioServicesPlaySystemSound(1150)
            }
        }
    }
    
    // Be aware that if you want to receive messages continuously
    // you need to call this again after you’ve finished receiving a message.
    // Basically we need to wrap this into a recursive call
    private func receiveMessage() {

        webSocketTask.receive { (result) in
            debugPrint("📩")
            switch result {
            case .failure(_):
                break
            case .success(let message):
                switch message {
                case .data(_):
                    break
                case .string(let encoded):
                    // Decode the participant information
                    self.decodeMessage(encoded)
                    break
                @unknown default:
                    break
                }
                break
            }

            self.receiveMessage()
        }
    }
    
    private func decodeMessage(_ encoded: String) {

        guard let data = encoded.data(using: .utf8), let participant: Participant = try? self.decoder.decode(Participant.self, from: data) else {
            return
        }
        
        if let i = room.participants.firstIndex(where: { $0.uid == participant.uid }) {
            DispatchQueue.main.async {
                self.room.participants[i].coordinates = participant.coordinates
            }
            
        } else {
            DispatchQueue.main.async {
                self.room.participants.append(participant)
            }
        }
    }
}

extension SocketRoomService: URLSessionWebSocketDelegate {
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        debugPrint("❤️")
    }
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        debugPrint("☠️")
        AudioServicesPlaySystemSound(1152)
    }
}
