//
//  FetchService.swift
//  Jokes
//
//  Created by Martin Hrbáček on 07.01.2026.
//

import Foundation

enum FileError: Error {
    case invalidURL
    case decodingFail
    case noJokeAvailable
}

@MainActor
class FetchService {
    
    func fetchRandomJoke(type: JokeType?) async throws -> Joke {
        guard let url = Bundle.main.url(forResource: "jokes", withExtension: "json") else {
            throw FileError.invalidURL
        }
        
        do {
            let data = try Data(contentsOf: url)
            let jokes = try JSONDecoder().decode([Joke].self, from: data)
            
            let allJokes: [Joke]
            if let type = type {
                allJokes = jokes.filter { $0.type == type }
            } else {
                allJokes = jokes
            }
            
            guard let randomJoke = allJokes.randomElement() else {
                throw FileError.noJokeAvailable
            }
            return randomJoke
            
        } catch {
            throw FileError.decodingFail
        }
    }
}
