//
//  JokeMenuView.swift
//  Jokes
//
//  Created by Martin Hrbáček on 08.01.2026.
//

import SwiftUI
import TipKit

struct JokeMenuView: View {
    
    @State private var arrowBounce: Bool = false
    @State private var showAboutView: Bool = false
    @State private var isHeaderAppear: Bool = false
    @State private var isSubTitleAppear: Bool = false
    @State private var isArrowAppear: Bool = false
    
    var body: some View {
        ZStack {
            
            LinearGradient(
                colors: GradientMainBackground.gradientMainColors,
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                VStack {
                    if isHeaderAppear {
                        Text("Ready to laugh?")
                            .font(.system(size: 45, weight: .heavy, design: .rounded))
                            .frame(height: 200)
                            .shadow(color: .black.opacity(0.4), radius: 20)
                            .padding()
                    }
                }
                
                Spacer()
                
                VStack {
                    if isSubTitleAppear {
                        Text("Choose the category and have a great day!")
                            .font(.system(size: 25, design: .rounded))
                            .bold()
                            .shadow(color: .black.opacity(0.4), radius: 15)
                            .padding()
                    }
                    
                    if isArrowAppear {
                        Image(systemName: "hand.point.up")
                            .font(.system(size: 30, design: .rounded))
                            .bold()
                            .foregroundStyle(
                                .black
                                    .shadow(
                                        .inner(
                                            color: .white.opacity(0.2),
                                            radius: 15
                                        )
                                    )
                                    .shadow(
                                        .drop(
                                            color: .black.opacity(0.8),
                                            radius: 20
                                        )
                                    )
                            )
                            .symbolEffect(.bounce, options: .repeating, value: arrowBounce)
                            .onAppear {
                                arrowBounce = true
                            }
                    }
                }
                .padding()
                
                Spacer()
            }
            .multilineTextAlignment(.center)
        }
        .onAppear {
            Task {
                withAnimation(.easeInOut(duration: 0.7)) {
                    isHeaderAppear = true
                }
                
                try? await Task.sleep(for: .seconds(0.5))
                
                withAnimation(.easeInOut(duration: 0.7)) {
                    isSubTitleAppear = true
                }
                
                try? await Task.sleep(for: .seconds(0.5))
                
                withAnimation(.easeInOut(duration: 0.7)) {
                    isArrowAppear = true
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showAboutView.toggle()
                } label: {
                    Image(systemName: "questionmark")
                        .font(.system(size: 18, weight: .heavy, design: .rounded))
                }
            }
        }
        .sheet(isPresented: $showAboutView) {
            JokeAboutView()
        }
    }
}

#Preview {
    NavigationStack {
        JokeMenuView()
    }
}
