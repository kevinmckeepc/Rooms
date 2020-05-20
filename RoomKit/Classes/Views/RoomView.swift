//
//  RoomView.swift
//
//  Created by Kevin McKee
//  Copyright © 2020 Kevin McKee. All rights reserved.
//

import SwiftUI

public struct RoomView: View {
    
    @State
    public var presentingRooms = false

    @EnvironmentObject
    public var room: Room
    
    public init() {
        
    }

    public var body: some View {
        
        ZStack {
            
            HStack {
                VStack {
                    Spacer()
                    self.actionButton
                }
                .padding()
            }
            .background(Color.white)
            .gesture(
                DragGesture()
                .onChanged({ (value) in
                    guard self.room.isConnected else { return }
                    // Publish our location
                    Rooms.update(value.location)
                })
            )
            
            // Our list of participants
            ForEach(self.room.participants) { participant in
                ParticipantView(participant: participant)
                .position(participant.coordinates)
            }
        }
    }

    private var actionButton: some View {
        
        let label: String = room.isConnected ? "Leave Room" : "Join Room"
        let theme: ThemeStyle = room.isConnected ? .error : .success

        let button = Button(label) {
            if self.room.isConnected {
                Rooms.leave {
                    debugPrint("Left room")
                }
            } else {
                debugPrint("Presenting join dialog")
                self.presentingRooms = true
            }
        }
        .buttonStyle(ThemedButtonStyle(theme: theme))
            
        let sheet = button.sheet(isPresented: $presentingRooms, onDismiss: {
            debugPrint("Dismissed Sheet")
        }) {
            JoinView().environmentObject(self.room).padding()
        }
        
        return Group() {
            if self.room.isConnected {
                button
            } else {
                sheet
            }
        }
    }
}

struct RoomView_Previews: PreviewProvider {
    
    static var previews: some View {
        RoomView()
    }
}
