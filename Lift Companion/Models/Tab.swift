//
//  Tab.swift
//  Lift Companion
//
//  Created by Eric on 14/07/24.
//

import SwiftUI

enum Tab: String {
    case lifts = "Lifts"
    case trends = "Trends"
    case profile = "Settings"

    @ViewBuilder
    var tabContent: some View {
        switch self {
        case .lifts:
            Image(systemName: "figure.strengthtraining.traditional")
            Text(rawValue)
        case .trends:
            Image(systemName: "chart.xyaxis.line")
            Text(rawValue)
        case .profile:
            Image(systemName: "gear")
            Text(rawValue)
        }
    }
}
