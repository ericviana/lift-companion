//
//  Lifts.swift
//  Lift Companion
//
//  Created by Eric on 14/07/24.
//

import SwiftUI

struct Lifts: View {
    @AppStorage("userName") private var userName: String = ""
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            NavigationStack {
                ScrollView(.vertical) {
                    LazyVStack(spacing: 10, pinnedViews: [.sectionHeaders], content: {
                        Section {} header: {
                            HeaderView(size)
                        }
                    })
                    .padding()
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
            
            Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            
            NavigationLink {} label: {
                Image(systemName: "plus")
                    .font(.title3)
                    .fontWeight(.semibold)
            }
            .visualEffect { content, geometryProxy in
                content
                    .scaleEffect(headerScale(size, proxy: geometryProxy), anchor: .topLeading)
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
