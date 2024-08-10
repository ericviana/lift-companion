//
//  Log.swift
//  Lift Companion
//
//  Created by Eric on 14/07/24.
//

import SwiftData
import SwiftUI

@Model
class Log {
    var exercise: String
    var reps: [Int]
    var sets: Int
    var dateAdded: Date
    var image: String
    var weights: [Double]

    init(exercise: Exercise, reps: [Int], sets: Int, dateAdded: Date, weights: [Double]) {
        self.exercise = exercise.rawValue
        self.reps = reps
        self.sets = sets
        self.dateAdded = dateAdded
        self.image = exercise.rawValue
        self.weights = weights
    }

    // Helper function to get formatted weight string with conversion
    func formattedWeight(for set: Int, unit: PreferredUnit) -> String {
        guard set < weights.count else { return "N/A" }
        var weight = weights[set]
        let unitString: String

        switch unit {
        case .pounds:
            unitString = "lbs"
        case .kilograms:
            weight = weight / 2.20462 // Convert pounds to kilograms
            unitString = "kg"
        }

        return String(format: "%.1f %@", weight, unitString)
    }
}

var sampleLogs: [Log] = [
    Log(exercise: .deadlift, reps: [5], sets: 3, dateAdded: Date().addingTimeInterval(-86400 * 2), weights: [225.0, 225.0, 225.0]),
    Log(exercise: .squat, reps: [8], sets: 4, dateAdded: Date().addingTimeInterval(-86400 * 2), weights: [185.0, 185.0, 185.0, 185.0]),
    Log(exercise: .bench, reps: [10], sets: 3, dateAdded: Date().addingTimeInterval(-86400), weights: [135.0, 135.0, 135.0]),
    Log(exercise: .deadlift, reps: [6], sets: 3, dateAdded: Date().addingTimeInterval(-86400), weights: [235.0, 235.0, 235.0]),
    Log(exercise: .squat, reps: [10], sets: 3, dateAdded: Date(), weights: [195.0, 195.0, 195.0]),
    Log(exercise: .bench, reps: [12], sets: 3, dateAdded: Date(), weights: [145.0, 145.0, 145.0]),
    Log(exercise: .deadlift, reps: [4], sets: 5, dateAdded: Date(), weights: [245.0, 245.0, 245.0, 245.0, 245.0]),
    Log(exercise: .squat, reps: [12], sets: 4, dateAdded: Date(), weights: [205.0, 205.0, 205.0, 205.0])
]
