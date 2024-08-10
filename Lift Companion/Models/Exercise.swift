//
//  Exercise.swift
//  Lift Companion
//
//  Created by Eric on 14/07/24.
//

import SwiftUI

enum Exercise: String, CaseIterable, Identifiable {
    var id: String { self.rawValue }

    case deadlift = "Deadlift"
    case bench = "Bench"
    case squat = "Squat"

    var image: Image {
        Image(rawValue.lowercased())
    }
}

enum PreferredUnit: String, Codable {
    case pounds = "lbs"
    case kilograms = "kg"
}
