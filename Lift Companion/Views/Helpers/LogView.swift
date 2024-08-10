//
//  LogView.swift
//  Lift Companion
//
//  Created by Eric on 20/07/24.
//

import SwiftUI

struct LogView: View {
    var log: Log
    @AppStorage("preferredUnit") private var preferredUnit: PreferredUnit = .pounds
    @State private var showAllSets = false

    var body: some View {
        VStack(spacing: 15) {
            HStack(alignment: .top, spacing: 15) {
                Image(log.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(.primary)
                    .padding(12)
                    .background(.quinary)
                    .clipShape(Circle())

                VStack(alignment: .leading, spacing: 6) {
                    Text(log.exercise)
                        .font(.title3.bold())
                        .foregroundColor(.primary)

                    HStack(spacing: 12) {
                        Label("\(log.reps.reduce(0, +)) reps", systemImage: "repeat")
                            .lineLimit(1)
                            .fixedSize(horizontal: true, vertical: false)

                        Label("\(log.sets) sets", systemImage: "square.stack.3d.up")
                            .lineLimit(1)
                            .fixedSize(horizontal: true, vertical: false)
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                }

                Spacer()

                Text(formattedDate(log.dateAdded))
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .cornerRadius(8)
                    .fixedSize(horizontal: true, vertical: false)
            }

            Divider()
                .background(Color.secondary.opacity(0.2))

            VStack(spacing: 12) {
                ForEach(0 ..< (showAllSets ? log.sets : min(log.sets, 3)), id: \.self) { index in
                    HStack {
                        Text("Set \(index + 1)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Spacer()
                        Text(log.formattedWeight(for: index, unit: preferredUnit))
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(.quinary)
                            .cornerRadius(8)
                    }
                }

                if log.sets > 3 {
                    Button(action: {
                        withAnimation(.spring(duration: 0.2)) {
                            showAllSets.toggle()
                        }
                    }) {
                        Text(showAllSets ? "Show less" : "Show all \(log.sets) sets")
                            .font(.footnote)
                            .foregroundColor(.accentColor)
                    }
                    .padding(.top, 5)
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.quinary.opacity(0.8))
        )
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        return formatter.string(from: date)
    }
}

#Preview {
    ContentView()
//    LogView(log: sampleLogs[0])
//        .padding()
//        .preferredColorScheme(.dark)
}
