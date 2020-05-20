import Foundation
import SwiftUI

public struct ParticipantView: View {
    
    var participant: Participant
    
    public var body: some View {
        
        ZStack {
            Rectangle()
            .fill(Color.green).cornerRadius(4)
            Text(participant.name)
            //Text("[\(Int(participant.coordinates.x)), \(Int(participant.coordinates.y))]" )
            //Text("\(participant.name) [\(participant.coordinates.x), \(participant.coordinates.y)]" )
        }
        .frame(minWidth: 0, maxWidth: 100, minHeight: 0, maxHeight: 50)
    }
}

