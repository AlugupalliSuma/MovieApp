//
//  SplashViewController.swift
//  MovieApp
//
//  Created by Suma on 31/12/24.
//

import UIKit

class SplashViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigateToHomeAfterDelay()
    }
    private func navigateToHomeAfterDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.navigateToHome()
        }
    }
    
    private func navigateToHome() {
        let homeVC = HomeViewController()
        homeVC.modalTransitionStyle = .crossDissolve
        homeVC.modalPresentationStyle = .fullScreen
        present(homeVC, animated: true, completion: nil)
    }
}
