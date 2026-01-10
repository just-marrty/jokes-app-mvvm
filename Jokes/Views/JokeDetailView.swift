//
//  ContentView.swift
//  Jokes
//
//  Created by Martin Hrbáček on 07.01.2026.
//

import SwiftUI

struct JokeDetailView: View {
    
    @State private var jokeVM: JokeViewModel
    
    init(type: JokeType) {
        _jokeVM = State(initialValue: JokeViewModel(fetchService: FetchService(), jokeType: type))
    }
    
    var body: some View {
        ZStack {
            
            LinearGradient(
                colors: GradientMainBackground.gradientMainColors,
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            Group {
                if let errorMessage = jokeVM.errorMessage {
                    VStack {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.system(size: 30, weight: .heavy, design: .rounded))
                            .padding()
                        Text(errorMessage)
                            .font(.system(size: 25, weight: .heavy, design: .rounded))
                            .multilineTextAlignment(.center)
                    }
                } else if let jokes = jokeVM.joke {
                    VStack {
                        Spacer()
                        
                        Text(jokes.setup)
                            .foregroundStyle(jokeVM.isSetupVisible ? .clear : .black)
                            .multilineTextAlignment(.center)
                            .font(.system(size: 36, weight: .heavy, design: .rounded))
                            .shadow(color: .black.opacity(0.4), radius: 15)
                            .frame(height: 300)
                            .padding()
                        
                        Spacer()
                        
                        Group {
                            if jokeVM.isPunchlineRevealed == true {
                                Text(jokes.punchline)
                                    .foregroundStyle(jokeVM.isPunchlineVisible ? .black : .clear)
                                    .shadow(color: .black.opacity(0.4), radius: 15)
                                    .padding()
                                    .font(.system(size: 30, design: .rounded))
                                    .bold()
                                    .frame(height: 300)
                                    .padding()
                            } else {
                                Image(systemName: "hand.tap")
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
                                    .frame(height: 300)
                                    .padding()
                                    .symbolEffect(.bounce, options: .repeating, value: jokeVM.handTapBounce)
                                    .onAppear {
                                        jokeVM.handTapBounce = true
                                    }
                            }
                        }
                        .padding()
                        .multilineTextAlignment(.center)
                        .opacity(jokeVM.isHandTapVisible ? 1 : 0)
                    }
                } else {
                    ProgressView()
                }
            }
        }
        .onTapGesture {
            if jokeVM.isPunchlineRevealed {
                Task {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        jokeVM.isPunchlineVisible = false
                        jokeVM.isHandTapVisible = false
                    }
                    
                    try? await Task.sleep(for: .seconds(0.5))
                    
                    withAnimation(.easeInOut(duration: 0.5)) {
                        jokeVM.isSetupVisible = true
                    }
                    
                    try? await Task.sleep(for: .seconds(0.5))
                    
                    await jokeVM.loadRanomJoke()
                    
                    jokeVM.isPunchlineRevealed = false
                    jokeVM.handTapBounce = false
                    
                    withAnimation(.easeInOut(duration: 0.7)) {
                        jokeVM.isSetupVisible = false
                    }
                    
                    try? await Task.sleep(for: .seconds(0.5))
                    
                    withAnimation(.easeInOut(duration: 0.5)) {
                        jokeVM.isHandTapVisible = true
                    }
                }
            } else {
                withAnimation(.easeInOut(duration: 0.7)) {
                    jokeVM.isPunchlineRevealed = true
                    jokeVM.isPunchlineVisible = true
                }
            }
        }
        .onAppear {
            jokeVM.resetJoke()
        }
        .task {
            await jokeVM.loadRanomJoke()
        }
    }
}


#Preview {
    NavigationStack {
        JokeDetailView(type: .wordplay)
    }
}
