//
//  Movie Data.swift
//  MovieApp
//
//  Created by Suma on 28/12/24.
//

import Foundation

struct MovieResponse: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let id: Int
    let title: String
    let posterPath: String
}

struct MovieDetails: Codable {
    let title: String
    let overview: String
    let releaseDate: String
    let posterPath: String
}
