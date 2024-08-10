//
//  Profile.swift
//  Lift Companion
//
//  Created by Eric on 14/07/24.
//

import SwiftUI

struct Profile: View {
    @AppStorage("userName") private var userName: String = ""
    @AppStorage("preferredUnit") private var preferredUnit: PreferredUnit = .kilograms

    var body: some View {
        NavigationStack {
            List {
                Section("User Name") {
                    TextField("Eric", text: $userName)
                }

                Section("Preferred Unit") {
                    Picker("Unit", selection: $preferredUnit) {
                        Text("Pounds (lbs)").tag(PreferredUnit.pounds)
                        Text("Kilograms (kg)").tag(PreferredUnit.kilograms)
                    }
                    .pickerStyle(.menu)
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    Profile()
}
