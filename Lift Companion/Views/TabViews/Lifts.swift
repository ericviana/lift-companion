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
    @State private var startDate: Date = .now.startOfMonth
    @State private var endDate: Date = .now.startOfMonth
    @State private var selectedExercise: Exercise = .deadlift
    @State private var logToDelete: Log?
    @State private var showingDeleteAlert = false
    @Namespace private var animation
    @Query(sort: [SortDescriptor(\Log.dateAdded, order: .reverse)], animation: .snappy) private var lifts: [Log]

    var body: some View {
        GeometryReader {
            let size = $0.size
            NavigationStack {
                ScrollView(.vertical) {
                    LazyVStack(spacing: 10, pinnedViews: [.sectionHeaders]) {
                        Section {
                            VStack(spacing: 10) {
                                CustomSegmentedControl()
                                    .padding(.bottom, 10)

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
                        } header: {
                            HeaderView(size)
                        }
                    }
                    .padding()
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

    @ViewBuilder
    func HeaderView(_ size: CGSize) -> some View {
        HStack(spacing: 10, content: {
            VStack(alignment: .leading, spacing: 5, content: {
                Text("Lift Companion")
                    .font(.title.bold())
            })

            Spacer(minLength: 0)

            NavigationLink { AddLogView() } label: {
                Image(systemName: "plus")
                    .font(.title3)
                    .fontWeight(.semibold)
            }
            .visualEffect { content, _ in
                content
                    .scaleEffect()
            }

        })
        .visualEffect { content, geometryProxy in
            content
                .scaleEffect(headerScale(size, proxy: geometryProxy), anchor: .topLeading)
        }
        .padding(.bottom, 5)
        .background {
            VStack {
                Rectangle()
                    .fill(.ultraThinMaterial)
            }
            .visualEffect { content, geometryProxy in
                content
                    .opacity(headerBgOpacity(proxy: geometryProxy))
            }
            .padding(.horizontal, -15)
            .padding(.top, -(safeArea.top + 15))
        }
    }

    @ViewBuilder
    func CustomSegmentedControl() -> some View {
        HStack(spacing: 0, content: {
            ForEach(Exercise.allCases, id: \.rawValue) { exercise in
                Text(exercise.rawValue)
                    .hSpacing()
                    .padding(.vertical, 10)
                    .background {
                        if exercise == selectedExercise {
                            Capsule()
                                .fill(.gray.opacity(0.3))
                                .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                        }
                    }
                    .contentShape(.capsule)
                    .onTapGesture {
                        withAnimation(.snappy(duration: 0.2)) {
                            selectedExercise = exercise
                        }
                    }
            }
        })
        .background(.gray.opacity(0.15), in: .capsule)
        .padding(.top, 5)
    }

    func headerBgOpacity(proxy: GeometryProxy) -> CGFloat {
        let minY = proxy.frame(in: .scrollView).minY + safeArea.top

        return minY > 0 ? 0 : (-minY / 15)
    }

    func headerScale(_ size: CGSize, proxy: GeometryProxy) -> CGFloat {
        let minY = proxy.frame(in: .scrollView).minY
        let screenHeight = size.height

        let progress = minY / screenHeight
        let scale = min(max(progress, 0), 1) * 0.6
        return 1 + scale
    }
}

#Preview {
    ContentView()
}
