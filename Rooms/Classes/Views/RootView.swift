//
//  RootView.swift
//  Rooms
//
//  Created by Kevin McKee on 5/20/20.
//  Copyright © 2020 Kevin McKee. All rights reserved.
//

import SwiftUI
import RoomKit

struct RootView: View {
    var body: some View {
        RoomView().environmentObject(Rooms.room)
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
