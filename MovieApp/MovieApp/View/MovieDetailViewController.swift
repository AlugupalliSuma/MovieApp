//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by Suma on 31/12/24.
//

import UIKit

class MovieDetailViewController: UIViewController {
    private let movieId: Int
    private var viewModel: MovieViewModel!
    private let titleLabel = UILabel()
    private let overviewLabel = UILabel()
    private let releaseDateLabel = UILabel()
    private let posterImageView = UIImageView()
    
    init(movieId: Int) {
        self.movieId = movieId
        super.init(nibName: nil, bundle: nil)
        self.viewModel = MovieViewModel() // Initialize ViewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        bindViewModel()
        viewModel.fetchMovieDetails(movieId: movieId) // Fetch movie details via ViewModel
    }
    
    private func setupUI() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(titleLabel)
        view.addSubview(overviewLabel)
        view.addSubview(releaseDateLabel)
        view.addSubview(posterImageView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            posterImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            posterImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            posterImageView.widthAnchor.constraint(equalToConstant: 200),
            posterImageView.heightAnchor.constraint(equalToConstant: 300),
            
            overviewLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 20),
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            releaseDateLabel.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 10),
            releaseDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            releaseDateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func bindViewModel() {
        viewModel.onMovieDetailsUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.updateUI()
            }
        }
    }
    
    private func updateUI() {
        guard let movieDetails = viewModel.getMovieDetails() else { return }
        
        titleLabel.text = movieDetails.title
        overviewLabel.text = movieDetails.overview
        releaseDateLabel.text = "Release Date: \(movieDetails.releaseDate)"
        
        if let url = URL(string: "https://image.tmdb.org/t/p/w500\(movieDetails.posterPath)") {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.posterImageView.image = UIImage(data: data)
                    }
                }
            }
        }
    }
}
