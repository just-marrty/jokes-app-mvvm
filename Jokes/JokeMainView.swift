//
//  JokeMainView.swift
//  Jokes
//
//  Created by Martin Hrbáček on 08.01.2026.
//

import SwiftUI

struct JokeMainView: View {
    
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house") {
                NavigationStack {
                    JokeMenuView()
                }
            }
            
            Tab("Wordplay", systemImage: "text.page") {
                NavigationStack {
                    JokeDetailView(type: .wordplay)
                }
            }
            
            Tab("Animals", systemImage: "dog") {
                NavigationStack {
                    JokeDetailView(type: .animal)
                }
            }
            
            Tab("Food", systemImage: "fork.knife") {
                NavigationStack {
                    JokeDetailView(type: .food)
                }
            }
            
            Tab("Objects", systemImage: "umbrella") {
                NavigationStack {
                    JokeDetailView(type: .objects)
                }
            }
        }
    }
}

#Preview {
    JokeMainView()
}
