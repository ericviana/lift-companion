//
//  Lifts.swift
//  Lift Companion
//
//  Created by Eric on 14/07/24.
//

import SwiftData
import SwiftUI

struct Lifts: View {
    @AppStorage("userName") private var userName: String = ""
    @Environment(\.modelContext) private var context
    @State private var selectedExercise: Exercise = .deadlift
    @State private var logToDelete: Log?
    @State private var showingDeleteAlert = false
    @Query(sort: [SortDescriptor(\Log.dateAdded, order: .reverse)], animation: .snappy) private var lifts: [Log]

    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack(spacing: 10) {
                    Picker("Exercise", selection: $selectedExercise) {
                        ForEach(Exercise.allCases) { exercise in
                            Text(exercise.rawValue).tag(exercise)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.bottom)

                    ForEach(lifts.filter { $0.exercise == selectedExercise.rawValue }, id: \.id) { log in
                        NavigationLink {
                            AddLogView(editLog: log)
                        } label: {
                            LogView(log: log)
                        }
                        .buttonStyle(.plain)
                        .contextMenu {
                            Button("Delete", role: .destructive) {
                                logToDelete = log
                                showingDeleteAlert = true
                            }
                        }
                        .gesture(
                            LongPressGesture(minimumDuration: 0.5)
                                .onEnded { _ in
                                    logToDelete = log
                                    showingDeleteAlert = true
                                }
                        )
                    }
                }
                .padding()
            }
            .navigationTitle("Lift Companion")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: AddLogView()) {
                        Image(systemName: "plus")
                    }
                }
            }
            .alert("Delete Log", isPresented: $showingDeleteAlert) {
                Button("Delete", role: .destructive) {
                    if let logToDelete = logToDelete {
                        context.delete(logToDelete)
                        try? context.save()
                    }
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("Are you sure you want to delete this log?")
            }
        }
    }
}

#Preview {
    ContentView()
}
