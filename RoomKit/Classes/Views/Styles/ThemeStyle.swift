//
//  ThemeStyle.swift
//
//  Created by Kevin McKee
//  Copyright © 2020 Kevin McKee. All rights reserved.
//

import SwiftUI

public enum ThemeStyle: String, Identifiable, CaseIterable {
    
    case success
    case primary
    case warning
    case error
    case dark
    
    public var id: String { rawValue }
    
    var foregroundColor: Color {
        switch self {
        case .warning:
            return .black
        default:
            return .white
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .success:
            return .green
        case .primary:
            return .blue
        case .warning:
            return .yellow
        case .error:
            return .red
        case .dark:
           return .black
        }
    }
}
