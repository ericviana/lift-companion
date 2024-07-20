//
//  Log.swift
//  Lift Companion
//
//  Created by Eric on 14/07/24.
//

import SwiftUI

struct Log: Identifiable {
    let id: UUID = .init()

    var exercise: String
    var reps: Int
    var sets: Int
    var dateAdded: Date

    init(exercise: Exercise, reps: Int, sets: Int, dateAdded: Date) {
        self.exercise = exercise.rawValue
        self.reps = reps
        self.sets = sets
        self.dateAdded = dateAdded
    }
}

var sampleLogs: [Log] = [
    Log(exercise: .deadlift, reps: 5, sets: 3, dateAdded: Date().addingTimeInterval(-86400 * 2)),
    Log(exercise: .squat, reps: 8, sets: 4, dateAdded: Date().addingTimeInterval(-86400 * 2)),
    Log(exercise: .bench, reps: 10, sets: 3, dateAdded: Date().addingTimeInterval(-86400)),
    Log(exercise: .deadlift, reps: 6, sets: 3, dateAdded: Date().addingTimeInterval(-86400)),
    Log(exercise: .squat, reps: 10, sets: 3, dateAdded: Date()),
    Log(exercise: .bench, reps: 12, sets: 3, dateAdded: Date()),
    Log(exercise: .deadlift, reps: 4, sets: 5, dateAdded: Date()),
    Log(exercise: .squat, reps: 12, sets: 4, dateAdded: Date())
]
