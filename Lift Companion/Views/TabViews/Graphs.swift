//
//  Graphs.swift
//  Lift Companion
//
//  Created by Eric on 10/08/24.
//

import Charts
import SwiftData
import SwiftUI

struct Graphs: View {
    @Query(animation: .snappy) private var logs: [Log]
    @State private var timeRange: TimeRange = .month

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    timeRangePicker
                    exerciseLegend
                    weightProgressChart
                    volumeChart
                    repsChart
                    frequencyChart
                }
                .padding()
            }
            .navigationTitle("Trends")
        }
    }
    
    private var timeRangePicker: some View {
        Picker("Time Range", selection: $timeRange) {
            ForEach(TimeRange.allCases) { range in
                Text(range.rawValue).tag(range)
            }
        }
        .pickerStyle(.segmented)
    }
    
    private var weightProgressChart: some View {
        chartWithTitle("Weight Progress") {
            Chart {
                ForEach(Exercise.allCases, id: \.self) { exercise in
                    ForEach(filteredLogs.filter { $0.exercise == exercise.rawValue }) { log in
                        LineMark(
                            x: .value("Date", log.dateAdded),
                            y: .value("Max Weight", log.weights.max() ?? 0),
                            series: .value("Exercise", exercise.rawValue)
                        )
                        .foregroundStyle(colorForExercise(exercise.rawValue))
                        .lineStyle(StrokeStyle(lineWidth: 2, dash: exercise == .bench ? [5, 5] : []))
                    }
                }
            }
            .chartXAxis {
                AxisMarks(preset: .automatic)
            }
            .chartYAxis {
                AxisMarks(position: .leading)
            }
            .chartLegend(position: .bottom, spacing: 20)
        }
    }

    private var volumeChart: some View {
        chartWithTitle("Workout Volume") {
            Chart(filteredLogs) { log in
                BarMark(
                    x: .value("Date", log.dateAdded),
                    y: .value("Volume", calculateVolume(log))
                )
                .foregroundStyle(colorForExercise(log.exercise))
            }
            .chartXAxis {
                AxisMarks(preset: .automatic)
            }
        }
    }
    
    private var repsChart: some View {
        chartWithTitle("Total Reps per Workout") {
            Chart(filteredLogs) { log in
                PointMark(
                    x: .value("Date", log.dateAdded),
                    y: .value("Total Reps", log.reps.reduce(0, +))
                )
                .foregroundStyle(colorForExercise(log.exercise))
            }
            .chartXAxis {
                AxisMarks(preset: .automatic)
            }
        }
    }
    
    private var frequencyChart: some View {
        chartWithTitle("Workout Frequency by Day of Week") {
            Chart {
                ForEach(Exercise.allCases, id: \.self) { exercise in
                    ForEach(workoutFrequency(for: exercise).sorted(by: { $0.key < $1.key }), id: \.key) { item in
                        BarMark(
                            x: .value("Day of Week", item.key),
                            y: .value("Frequency", item.value)
                        )
                        .foregroundStyle(colorForExercise(exercise.rawValue))
                    }
                }
            }
        }
    }
    
    private var exerciseLegend: some View {
        HStack {
            ForEach(Exercise.allCases) { exercise in
                HStack {
                    Circle()
                        .fill(colorForExercise(exercise.rawValue))
                        .frame(width: 10, height: 10)
                    Text(exercise.rawValue)
                        .font(.caption)
                }
            }
        }
    }
    
    private var filteredLogs: [Log] {
        logs.filter { isInSelectedTimeRange($0.dateAdded) }
    }
    
    private func isInSelectedTimeRange(_ date: Date) -> Bool {
        let calendar = Calendar.current
        let now = Date()
        switch timeRange {
        case .week:
            return calendar.isDate(date, equalTo: now, toGranularity: .weekOfYear)
        case .month:
            return calendar.isDate(date, equalTo: now, toGranularity: .month)
        case .year:
            return calendar.isDate(date, equalTo: now, toGranularity: .year)
        }
    }
    
    private func calculateVolume(_ log: Log) -> Double {
        zip(log.weights, log.reps.map(Double.init)).map(*).reduce(0, +)
    }
    
    private func workoutFrequency(for exercise: Exercise) -> [String: Int] {
        let calendar = Calendar.current
        let weekdays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
        var frequency: [String: Int] = Dictionary(uniqueKeysWithValues: weekdays.map { ($0, 0) })
        
        for log in filteredLogs where log.exercise == exercise.rawValue {
            let weekday = calendar.component(.weekday, from: log.dateAdded)
            let weekdayString = weekdays[weekday - 1]
            frequency[weekdayString, default: 0] += 1
        }
        
        return frequency
    }
    
    private func chartWithTitle(_ title: String, @ViewBuilder content: @escaping () -> some View) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .padding(.bottom, 12)
            content()
                .frame(height: 200)
        }
    }
    
    private func colorForExercise(_ exercise: String) -> Color {
        switch exercise {
        case "Deadlift":
            return .red
        case "Bench":
            return .yellow
        case "Squat":
            return .purple
        default:
            return .gray
        }
    }
}

enum TimeRange: String, CaseIterable, Identifiable {
    case week = "Week"
    case month = "Month"
    case year = "Year"
    
    var id: String { rawValue }
}

#Preview {
    Graphs()
}
