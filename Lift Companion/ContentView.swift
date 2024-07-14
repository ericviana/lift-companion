//
//  ContentView.swift
//  Lift Companion
//
//  Created by Eric on 13/07/24.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isFirstTime") private var isFirstTime: Bool = true
    
    @State private var activeTab: Tab = .lifts
    var body: some View {
        TabView(selection: $activeTab) {
            Lifts()
                .tag(Tab.lifts)
                .tabItem { Tab.lifts.tabContent }
            Trends()
                .tag(Tab.trends)
                .tabItem { Tab.trends.tabContent }
            Profile()
                .tag(Tab.profile)
                .tabItem { Tab.profile.tabContent }
        }
        .sheet(isPresented: $isFirstTime, content: {
            IntroView()
                .interactiveDismissDisabled()
        })
    }
}

#Preview {
    ContentView()
}
