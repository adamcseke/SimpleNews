//
//  FavoritesViewController.swift
//  SimpleNews
//
//  Created by Adam Cseke on 2021. 11. 29..
//

import UIKit

class FavoritesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    private func setup() {
        configureNavigationController()
    }
    private func configureNavigationController() {
        navigationItem.title = "Favorites"
        view.backgroundColor = .systemBackground
    }
}
