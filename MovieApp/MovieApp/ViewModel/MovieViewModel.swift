//
//  MovieViewModel.swift
//  MovieApp
//
//  Created by Suma on 27/12/24.
//

import Foundation

class MovieViewModel {
    private let apiManager = APIManager.shared
    private var movies: [Movie] = []
    private var movieDetails: MovieDetails?
    
    // Binding closure for updating the UI in the ViewController
    var onMoviesUpdated: (() -> Void)?
    var onMovieDetailsUpdated: (() -> Void)?
    
    func fetchMovies() {
        apiManager.fetchPopularMovies { [weak self] movies in
            self?.movies = movies
            self?.onMoviesUpdated?() // Notify the view that movies are updated
        }
    }
    
    func fetchMovieDetails(movieId: Int) {
        apiManager.fetchMovieDetails(movieId: movieId) { [weak self] details in
            self?.movieDetails = details
            self?.onMovieDetailsUpdated?() // Notify the view that movie details are updated
        }
    }
    
    func getMovie(at index: Int) -> Movie {
        return movies[index]
    }
    
    func getMovieDetails() -> MovieDetails? {
        return movieDetails
    }
    
    func getMoviesCount() -> Int {
        return movies.count
    }
}
