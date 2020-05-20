//
//  RoundThemedButtonStyle.swift
//
//  Created by Kevin McKee
//  Copyright © 2020 Kevin McKee. All rights reserved.
//

import SwiftUI

public struct RoundThemedButtonStyle: ButtonStyle {
        
    var theme: ThemeStyle

    public func makeBody(configuration: Self.Configuration) -> some View {
        
        Circle()
            .fill(theme.backgroundColor)
//        .overlay(
//            Circle()
//                .stroke(lineWidth: 2)
//                .foregroundColor(theme.foregroundColor)
//                .padding(4)
//        )
        .overlay(
            configuration.label
            .foregroundColor(theme.foregroundColor)
            .padding()
        )
        .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}


public struct RoundThemedButtonPreview: PreviewProvider {
    
    public static var previews: some View {
        
        VStack(spacing: 10) {
            
            ForEach(ThemeStyle.allCases) { theme in
                Button(action: {
                    
                }) {
                    Image(systemName: "plus")
                    .font(.largeTitle)
                }
                .buttonStyle(RoundThemedButtonStyle(theme: theme))
            }
        }
    }
}
