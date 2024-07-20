//
//  IntroView.swift
//  Lift Companion
//
//  Created by Eric on 14/07/24.
//

import SwiftUI

struct IntroView: View {
    @AppStorage("isFirstTime") private var isFirstTime: Bool = true

    var body: some View {
        VStack(spacing: 15) {
            Text("Meet Your New Lifting Companion.")
                .font(.largeTitle.bold())
                .multilineTextAlignment(.center)
                .padding(.top, 65)
                .padding(.bottom, 35)
        }
        VStack(alignment: .leading, spacing: 25, content: {
            PointView(symbol: "chart.dots.scatter", title: "Track your progress.", subtitle: "Molestiae possimus veniam impedit.")
            PointView(symbol: "flame", title: "Keep yourself accountable.", subtitle: "Lorem Ipsum dolor sit ammet.")
            PointView(symbol: "figure.strengthtraining.traditional", title: "Get real strong.", subtitle: "Lorem Ipsum dolor sit ammet.")
        })
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 25)

        Spacer(minLength: 10)

        Button(action: {
            isFirstTime = false
        }, label: {
            Text("Let's Go")
                .frame(maxWidth: .infinity)
                .padding()
        })
        .buttonStyle(.borderedProminent)
        .background(appTint)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding()
    }

    @ViewBuilder
    func PointView(symbol: String, title: String, subtitle: String) -> some View {
        HStack(spacing: 15) {
            Image(systemName: symbol)
                .font(.title)
                .foregroundStyle(appTint)
                .frame(width: 45)

            VStack(alignment: .leading, spacing: 6, content: {
                Text(title)
                    .font(.title3)
                    .fontWeight(.semibold)

                Text(subtitle)
                    .foregroundStyle(.gray)
            })
        }
    }
}

#Preview {
    IntroView()
}
