//
//  Trends.swift
//  Lift Companion
//
//  Created by Eric on 14/07/24.
//

import SwiftData
import SwiftUI

struct Trends: View {
    @Query(animation: .snappy) private var logs: [Log]

    var body: some View {
        if logs.isEmpty {
            VStack {
                Text("Go lift you lazy fat!")
                Text("No workout data available yet.")
                    .foregroundStyle(.secondary)
            }
        } else {
            Graphs()
        }
    }
}

#Preview {
    ContentView()
}
