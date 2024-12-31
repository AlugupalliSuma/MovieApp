//
//  ViewController.swift
//  MovieApp
//
//  Created by Suma on 27/12/24.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var viewModel = MovieViewModel() // The ViewModel
    @IBOutlet weak var customNavBar: CustomNavigationView!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        customNavBar.configure("Popular Movies")
        customNavBar.leftButton.isHidden = true
        setupTableView()
        bindViewModel()
        viewModel.fetchMovies() // Fetch movies via the ViewModel
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    // Binding the ViewModel to the View
    private func bindViewModel() {
        viewModel.onMoviesUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    // TableView DataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getMoviesCount() // Get count from ViewModel
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let movie = viewModel.getMovie(at: indexPath.row) // Get movie from ViewModel
        cell.textLabel?.text = movie.title
        return cell
    }
    
    // TableView Delegate Method
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = viewModel.getMovie(at: indexPath.row)
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if let movieDetailsVC = storyBoard.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController{
            movieDetailsVC.movieId = movie.id
            self.navigationController?.pushViewController(movieDetailsVC, animated: true)
        }
    }
}
