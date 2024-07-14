//
//  Trends.swift
//  Lift Companion
//
//  Created by Eric on 14/07/24.
//

import SwiftUI

struct Trends: View {
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            Color(UIColor.systemBackground)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 40) {
                Image(systemName: "hammer.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .foregroundColor(.accentColor)
                    .scaleEffect(isAnimating ? 1.05 : 1.0)
                    .animation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true), value: isAnimating)
                
                VStack(spacing: 16) {
                    Text("Coming Soon")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.primary)
                    
                    Text("I'm working hard to bring you something amazing.")
                        .font(.system(size: 17, weight: .regular))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                }
                
//                Button(action: {
//                }) {
//                    Text("Notify Me")
//                        .font(.system(size: 17, weight: .semibold, design: .rounded))
//                        .foregroundColor(.white)
//                        .padding(.horizontal, 30)
//                        .padding(.vertical, 12)
//                        .background(Color.accentColor)
//                        .clipShape(RoundedRectangle(cornerRadius: 12))
//                }
            }
        }
        .onAppear {
            isAnimating = true
        }
    }
}


#Preview {
    ContentView()
}
