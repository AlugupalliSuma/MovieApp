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
    let adult: Bool
    let backdropPath: String
    let genreIDs: [Int]
    let id: Int
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String
    let releaseDate: String
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    // Coding keys to map JSON keys to Swift properties
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDs = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}


struct MovieDetails: Codable {
    let title: String
    let overview: String
    let releaseDate: String
    let posterPath: String
    let adult: Bool
    let backdropPath: String
    let budget: Int
    let genres: [Genre]
    let homepage: String
    let id: Int
    let imdbID: String
    let originCountry: [String]
    let originalLanguage: String
    let originalTitle: String
    let popularity: Double
    let productionCompanies: [ProductionCompany]
    let productionCountries: [ProductionCountry]
    let revenue: Int
    let runtime: Int
    let spokenLanguages: [SpokenLanguage]
    let status: String
    let tagline: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    let belongsToCollection: BelongsToCollection?

    enum CodingKeys: String, CodingKey {
        case title, overview
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case adult
        case backdropPath = "backdrop_path"
        case budget
        case genres
        case homepage
        case id
        case imdbID = "imdb_id"
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case popularity
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case revenue
        case runtime
        case spokenLanguages = "spoken_languages"
        case status
        case tagline
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case belongsToCollection = "belongs_to_collection"
    }
}

struct Genre: Codable {
    let id: Int
    let name: String
}

struct ProductionCompany: Codable {
    let id: Int
    let logoPath: String?
    let name: String
    let originCountry: String

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}

struct ProductionCountry: Codable {
    let iso3166_1: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
}

struct SpokenLanguage: Codable {
    let englishName: String
    let iso639_1: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso639_1 = "iso_639_1"
        case name
    }
}

struct BelongsToCollection: Codable {
    let id: Int
    let name: String
    let posterPath: String?
    let backdropPath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}


//{"adult":false,"backdrop_path":"/xlkclSE4aq7r3JsFIJRgs21zUew.jpg","genre_ids":[27,53],"id":1034541,"original_language":"en","original_title":"Terrifier 3","overview":"Five years after surviving Art the Clown's Halloween massacre, Sienna and Jonathan are still struggling to rebuild their shattered lives. As the holiday season approaches, they try to embrace the Christmas spirit and leave the horrors of the past behind. But just when they think they're safe, Art returns, determined to turn their holiday cheer into a new nightmare. The festive season quickly unravels as Art unleashes his twisted brand of terror, proving that no holiday is safe.","popularity":806.96,"poster_path":"/ju10W5gl3PPK3b7TjEmVOZap51I.jpg","release_date":"2024-10-09","title":"Terrifier 3","video":false,"vote_average":6.9,"vote_count":1320}
