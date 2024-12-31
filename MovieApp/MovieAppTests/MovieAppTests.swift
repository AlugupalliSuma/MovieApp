//
//  MovieAppTests.swift
//  MovieAppTests
//
//  Created by Suma on 31/12/24.
//

import XCTest
@testable import MovieApp

final class MovieAppTests: XCTestCase {
    var networkManager: APIManager!
    
    override func setUp() {
        super.setUp()
        networkManager = APIManager()
    }
    
    override func tearDown() {
        networkManager = nil
        super.tearDown()
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testFetchPopularMovies() {
        let expectation = XCTestExpectation(description: "Fetch popular movies from API")
        
        APIManager.shared.fetchPopularMovies { movies in
            XCTAssertNotNil(movies, "Movies should not be nil")
            XCTAssertGreaterThan(movies.count, 0, "Movies count should be greater than 0")
            XCTAssertFalse(movies.contains { $0.title.isEmpty }, "All movies should have a title")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    func testFetchMovieDetails() {
        let expectation = XCTestExpectation(description: "Fetch movie details from API")
        let testMovieId = 550 // Example movie ID for testing (e.g., Fight Club)
        
        APIManager.shared.fetchMovieDetails(movieId: testMovieId) { details in
            XCTAssertNotNil(details, "Movie details should not be nil")
            XCTAssertEqual(details?.id, testMovieId, "Fetched details should match the movie ID")
            XCTAssertFalse(details?.title.isEmpty ?? true, "Movie title should not be empty")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    func testViewModelFetchMovies() {
        let viewModel = MovieViewModel()
        let expectation = XCTestExpectation(description: "ViewModel fetches movies")
        
        viewModel.onMoviesUpdated = {
            XCTAssertGreaterThan(viewModel.getMoviesCount(), 0, "Movies count should be greater than 0")
            expectation.fulfill()
        }
        
        viewModel.fetchMovies()
        wait(for: [expectation], timeout: 5.0)
    }
    func testViewModelFetchMovieDetails() {
        let viewModel = MovieViewModel()
        let testMovieId = 550 // Example movie ID for testing
        let expectation = XCTestExpectation(description: "ViewModel fetches movie details")
        
        viewModel.onMovieDetailsUpdated = {
            XCTAssertNotNil(viewModel.getMovieDetails(), "Movie details should not be nil")
            XCTAssertEqual(viewModel.getMovieDetails()?.id, testMovieId, "Fetched details should match the movie ID")
            expectation.fulfill()
        }
        
        viewModel.fetchMovieDetails(movieId: testMovieId)
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testHomeViewControllerFetchMovies() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        
        homeVC.loadViewIfNeeded()
        let expectation = XCTestExpectation(description: "HomeViewController fetches and displays movies")
        
        homeVC.viewModel.onMoviesUpdated = {
            XCTAssertGreaterThan(homeVC.viewModel.getMoviesCount(), 0, "Movies count should be greater than 0")
            expectation.fulfill()
        }
        
        homeVC.viewModel.fetchMovies()
        wait(for: [expectation], timeout: 5.0)
    }

    func testMovieDetailViewControllerFetchDetails() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        
        let testMovieId = 550
        detailVC.movieId = testMovieId
        detailVC.loadViewIfNeeded()
        
        let expectation = XCTestExpectation(description: "MovieDetailViewController fetches and displays details")
        
        detailVC.viewModel.onMovieDetailsUpdated = {
            XCTAssertNotNil(detailVC.viewModel.getMovieDetails(), "Movie details should not be nil")
            XCTAssertEqual(detailVC.viewModel.getMovieDetails()?.id, testMovieId, "Fetched details should match the movie ID")
            expectation.fulfill()
        }
        
        detailVC.viewModel.fetchMovieDetails(movieId: testMovieId)
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testMovieDetailsDecoding() {
        let json = """
        {
            "title": "Fight Club",
            "overview": "Test overview",
            "release_date": "1999-10-15",
            "poster_path": "/poster.jpg",
            "adult": false,
            "backdrop_path": "/backdrop.jpg",
            "budget": 63000000,
            "genres": [{"id": 18, "name": "Drama"}],
            "homepage": "https://www.example.com",
            "id": 550,
            "imdb_id": "tt0137523",
            "origin_country": ["US"],
            "original_language": "en",
            "original_title": "Fight Club",
            "popularity": 10.5,
            "production_companies": [],
            "production_countries": [],
            "revenue": 100000000,
            "runtime": 139,
            "spoken_languages": [],
            "status": "Released",
            "tagline": "Mischief. Mayhem. Soap.",
            "video": false,
            "vote_average": 8.4,
            "vote_count": 1000,
            "belongs_to_collection": null
        }
        """.data(using: .utf8)!
        
        let movieDetails = try? JSONDecoder().decode(MovieDetails.self, from: json)
        XCTAssertNotNil(movieDetails, "MovieDetails should decode successfully")
        XCTAssertEqual(movieDetails?.title, "Fight Club", "Title should match")
        XCTAssertEqual(movieDetails?.runtime, 139, "Runtime should match")
    }


}
