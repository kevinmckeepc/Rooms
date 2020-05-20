//
//  KeyboardResponderViewModifier.swift
//
//  Created by Kevin McKee
//  Copyright © 2020 Kevin McKee. All rights reserved.
//

import Foundation
import SwiftUI

public struct KeyboardResponderViewModifier: ViewModifier {
    
    @State private var offset: CGFloat = 0
    
    public func body(content: Content) -> some View {
        
        content
            .padding(.bottom, offset)
            .onAppear {
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notif in
                    let value = notif.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                    let height = value.height
                    let bottomInset = UIApplication.shared.windows.first?.safeAreaInsets.bottom
                    self.offset = height - (bottomInset ?? 0)
                }
                
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { notif in
                    self.offset = 0
                }
        }
    }
}

public extension View {
    
    func keyboardResponsive() -> ModifiedContent<Self, KeyboardResponderViewModifier> {
        return modifier(KeyboardResponderViewModifier())
    }
}
