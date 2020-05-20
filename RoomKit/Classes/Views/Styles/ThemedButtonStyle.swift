//
//  ThemedButtonStyle.swift
//
//  Created by Kevin McKee
//  Copyright © 2020 Kevin McKee. All rights reserved.
//

import SwiftUI

public struct ThemedButtonStyle: ButtonStyle {
        
    var theme: ThemeStyle

    public func makeBody(configuration: Self.Configuration) -> some View {
        
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .foregroundColor(theme.foregroundColor)
            .background(LinearGradient(gradient: Gradient(colors: [theme.backgroundColor, theme.backgroundColor]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(40)
            .padding(.horizontal, 20)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}


public struct ThemedButtonPreview: PreviewProvider {
    
    public static var previews: some View {
        
        VStack(spacing: 10) {
            
            ForEach(ThemeStyle.allCases) { theme in
                Button(action: {
                    
                }) {
                    HStack {
                        Text("Sample Button")
                            .fontWeight(.semibold)
                            .font(.title)
                    }
                }
                .buttonStyle(ThemedButtonStyle(theme: theme))
            }
        }
    }
}
