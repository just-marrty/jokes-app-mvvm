//
//  JokeAboutView.swift
//  Jokes
//
//  Created by Martin Hrbáček on 09.01.2026.
//

import SwiftUI

struct JokeAboutView: View {
    
    var body: some View {
        ZStack {
            
            LinearGradient(
                colors: GradientAboutBackground.gradientAboutColor,
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack {
                Text("About")
                    .font(.system(size: 24, design: .rounded))
                    .bold()
                    .shadow(color: .black.opacity(0.4), radius: 15)
                    .padding()
                Text("""
                    Hi! If you're reading this, whether on my GitHub or even in your Xcode, it means my work has caught someone's attention and I thank you for that! And now a little bit about the app.
                    
                    Jokes is a simple SwiftUI app that lets you enjoy random jokes by category. You can browse Wordplay, Animals, Food, and Objects using the tabs. 
                    
                    To use it, open any category, read the setup, then tap the screen to reveal the punchline; tap once more to load the next random joke. The app works offline because jokes are loaded from a local JSON file bundled with the app.
                    
                    Because jokes are selected randomly, repeats can happen, especially within smaller categories.
                    """)
                .font(.system(size: 20, design: .rounded))
                .bold()
                .multilineTextAlignment(.center)
                .padding()
            }
        }
    }
}

#Preview {
    NavigationStack {
        JokeAboutView()
    }
}
