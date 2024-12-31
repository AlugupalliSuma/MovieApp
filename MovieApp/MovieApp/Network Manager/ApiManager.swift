//
//  ApiManager.swift
//  MovieApp
//
//  Created by Suma on 28/12/24.
//

import Foundation

class APIManager {
    static let shared = APIManager()
    private let apiKey = "your_api_key" // Replace with your TMDb API key
    private let baseURL = "https://api.themoviedb.org/3"
    
    // Fetch popular movies
    func fetchPopularMovies(completion: @escaping ([Movie]) -> Void) {
        let urlString = "\(baseURL)/movie/popular?api_key=\(apiKey)"
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let json = try? JSONDecoder().decode(MovieResponse.self, from: data) {
                    completion(json.results)
                }
            }
        }
        task.resume()
    }
    
    // Fetch movie details
    func fetchMovieDetails(movieId: Int, completion: @escaping (MovieDetails?) -> Void) {
        let urlString = "\(baseURL)/movie/\(movieId)?api_key=\(apiKey)"
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let movieDetails = try? JSONDecoder().decode(MovieDetails.self, from: data) {
                    completion(movieDetails)
                }
            }
        }
        task.resume()
    }
}
