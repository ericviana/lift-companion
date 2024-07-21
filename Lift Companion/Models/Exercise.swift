//
//  Exercise.swift
//  Lift Companion
//
//  Created by Eric on 14/07/24.
//

import SwiftUI

enum Exercise: String, CaseIterable {
    case deadlift = "Deadlift"
    case squat = "Squat"
    case bench = "Bench"
}

enum PreferredUnit: String, Codable {
    case pounds = "lbs"
    case kilograms = "kg"
}
