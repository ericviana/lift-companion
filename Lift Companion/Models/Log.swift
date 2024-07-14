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
