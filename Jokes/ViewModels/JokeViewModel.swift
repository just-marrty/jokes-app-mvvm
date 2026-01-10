//
//  JokeViewModel.swift
//  Jokes
//
//  Created by Martin Hrbáček on 07.01.2026.
//

import Foundation
import Observation
import SwiftUI

@Observable
@MainActor
class JokeViewModel {
    var joke: Joke?
    var errorMessage: String? = nil
    var jokeType: JokeType
    var isPunchlineRevealed: Bool = false
    var handTapBounce: Bool = false
    var isPunchlineVisible: Bool = false
    var isSetupVisible: Bool = false
    var isHandTapVisible: Bool = true
    
    private let fetchService: FetchService
    
    init(fetchService: FetchService, jokeType: JokeType) {
        self.fetchService = fetchService
        self.jokeType = jokeType
    }
    
    func loadRanomJoke() async {
        errorMessage = nil
        do {
            self.joke = try await fetchService.fetchRandomJoke(type: jokeType)
        } catch {
            errorMessage = "Oops, something get wrong.."
        }
    }
    
    func resetJoke() {
        isPunchlineRevealed = false
        handTapBounce = false
        isPunchlineVisible = false
        isSetupVisible = false
        isHandTapVisible = true
    }
}
