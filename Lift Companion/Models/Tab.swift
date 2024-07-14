//
//  Tab.swift
//  Lift Companion
//
//  Created by Eric on 14/07/24.
//

import SwiftUI

enum Tab: String {
    case lifts = "Lifts"
    case trends = "Trends (AI)"
    case profile = "Profile"
    
    @ViewBuilder
    var tabContent: some View {
        switch self {
        case .lifts:
            Image(systemName: "figure.strengthtraining.traditional")
            Text(self.rawValue)
        case .trends:
            Image(systemName: "sparkles")
            Text(self.rawValue)
        case .profile:
            Image(systemName: "person.fill")
            Text(self.rawValue)
        }
    }
}
