//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by Suma on 31/12/24.
//

import UIKit

class MovieDetailViewController: UIViewController, CustomNavigationBarDelegate {
    func didTapLeftButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var customNavBar: CustomNavigationView!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    var movieId: Int!
    var viewModel = MovieViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        customNavBar.delegate = self
        viewModel.fetchMovieDetails(movieId: movieId) // Fetch movie details via ViewModel
        bindViewModel()
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
        customNavBar.configure(movieDetails.title)
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
