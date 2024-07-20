//
//  LogView.swift
//  Lift Companion
//
//  Created by Eric on 20/07/24.
//

import SwiftUI

struct LogView: View {
    var log: Log
    var body: some View {
        HStack(spacing: 12) {
            Text("\(String(log.exercise.prefix(1)))")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .frame(width: 45, height: 45)
                .background(.secondary, in: .circle)

            VStack(alignment: .leading, spacing: 4, content: {
                Text("\(log.exercise)")
                    .foregroundStyle(Color.primary)
                Text("\(log.reps) reps")
                    .font(.caption)
                    .foregroundStyle(Color.primary.secondary)
            })
            .lineLimit(1)
            .hSpacing(.leading)

            Text(format(date: log.dateAdded, format: "dd/MM/yyyy"))
                .font(.caption)
                .foregroundStyle(Color.secondary)
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
        .background(.thinMaterial.opacity(0.5), in: .rect(cornerRadius: 10))
    }
}

#Preview {
    LogView(log: sampleLogs[0])
}
