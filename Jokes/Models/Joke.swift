//
//  Joke.swift
//  Jokes
//
//  Created by Martin Hrbáček on 07.01.2026.
//

import Foundation

enum JokeType: String, Decodable {
    case wordplay = "wordplay"
    case animal = "animals"
    case food = "food"
    case objects = "objects"
}

struct Joke: Decodable, Identifiable {
    let type: JokeType
    let setup: String
    let punchline: String
    let id: Int
}
