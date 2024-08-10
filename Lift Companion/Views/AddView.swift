//
//  AddView.swift
//  Lift Companion
//
//  Created by Eric on 21/07/24.
//

import SwiftUI

struct AddLogView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    var editLog: Log?

    @State private var exercise: Exercise = .bench
    @State private var sets: Int = 3
    @State private var weights: [Double] = [0, 0]
    @State private var reps: [Int] = [8, 8]
    @State private var dateAdded: Date = .now
    @AppStorage("preferredUnit") private var preferredUnit: PreferredUnit = .kilograms

    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 32) {
                exercisePicker
                setsInput
                weightAndRepsInputs
                dateOfExecution
            }
        }
        .padding()
        .navigationTitle("Add Lift")
        .onChange(of: sets) { _, newValue in
            updateWeightsAndRepsArrays(newSets: newValue)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    save()
                }
            }
        }
        .onAppear {
            if let editLog {
                if let exerciseEnum = Exercise(rawValue: editLog.exercise) {
                    exercise = exerciseEnum
                }
                reps = editLog.reps
                sets = editLog.sets
                dateAdded = editLog.dateAdded
                weights = editLog.weights
            }
        }
    }

    func save() {
        if editLog != nil {
            editLog?.reps = reps
            editLog?.sets = sets
            editLog?.dateAdded = dateAdded
            editLog?.weights = weights
        } else {
            let log = Log(exercise: exercise, reps: reps, sets: sets, dateAdded: dateAdded, weights: weights)
            context.insert(log)
        }

        dismiss()
    }

    private var exercisePicker: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Select the exercise")
                .font(.subheadline)
                .foregroundStyle(.gray)
                .hSpacing(.leading)
            Picker("Select an exercise", selection: $exercise) {
                ForEach(Exercise.allCases) { exercise in
                    Text(exercise.rawValue).tag(exercise)
                }
            }
            .pickerStyle(.inline)
            .padding(.top, -42)
        }
    }

    private var setsInput: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Number of sets")
                .font(.subheadline)
                .foregroundStyle(.gray)
                .hSpacing(.leading)
            TextField("0", value: $sets, formatter: numberFormatter)
                .padding(.horizontal, 15)
                .padding(.vertical, 12)
                .background(.quinary, in: .rect(cornerRadius: 12))
                .keyboardType(.numberPad)
        }
    }

    private var weightAndRepsInputs: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Weight & Reps")
                .font(.subheadline)
                .foregroundStyle(.gray)
                .hSpacing(.leading)

            ForEach(0 ..< sets, id: \.self) { index in
                HStack {
                    Text("Set \(index + 1):")
                    TextField("0.0", value: Binding(
                        get: { index < weights.count ? weights[index] : 0.0 },
                        set: { newValue in
                            if index < weights.count {
                                weights[index] = newValue
                            } else {
                                weights.append(newValue)
                            }
                        }
                    ), formatter: numberFormatter)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 12)
                        .background(.quinary, in: .rect(cornerRadius: 12))
                        .keyboardType(.decimalPad)
                    Text(preferredUnit.rawValue)

                    Spacer()

                    TextField("0", value: Binding(
                        get: { index < reps.count ? reps[index] : 0 },
                        set: { newValue in
                            if index < reps.count {
                                reps[index] = newValue
                            } else {
                                reps.append(newValue)
                            }
                        }
                    ), formatter: numberFormatter)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 12)
                        .background(.quinary, in: .rect(cornerRadius: 12))
                        .keyboardType(.numberPad)
                        .frame(width: 80)
                    Text("reps")
                }
            }
        }
    }

    private var dateOfExecution: some View {
        HStack {
            Text("Activity date")
                .font(.subheadline)
                .foregroundStyle(.gray)
                .hSpacing(.leading)
            DatePicker("", selection: $dateAdded, displayedComponents: [.date])
                .datePickerStyle(.compact)
        }
    }

    private var previewSection: some View {
        VStack(spacing: 15) {
            Text("Preview")
                .font(.subheadline)
                .foregroundStyle(.gray)
                .hSpacing(.leading)

            LogView(
                log: Log(exercise: exercise,
                         reps: Array(reps.prefix(sets)),
                         sets: sets,
                         dateAdded: dateAdded,
                         weights: Array(weights.prefix(sets)))
            )
        }
    }

    private var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }

    private func updateWeightsAndRepsArrays(newSets: Int) {
        if newSets > weights.count {
            weights += Array(repeating: 0.0, count: newSets - weights.count)
            reps += Array(repeating: 0, count: newSets - reps.count)
        } else if newSets < weights.count {
            weights = Array(weights.prefix(newSets))
            reps = Array(reps.prefix(newSets))
        }
    }
}

#Preview {
    NavigationStack {
        AddLogView()
    }
}
