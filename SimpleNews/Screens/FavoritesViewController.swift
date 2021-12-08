//
//  FavoritesViewController.swift
//  SimpleNews
//
//  Created by Adam Cseke on 2021. 11. 29..
//

import UIKit

class FavoritesViewController: UIViewController {

    private let newsID: String
    
    init(newsID: String) {
        self.newsID = newsID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    private func setup() {
        configureNavigationController()
    }
    private func configureNavigationController() {
        navigationItem.title = "FavoritesScreen.ControllerTitle".localized
        view.backgroundColor = .systemBackground
    }
}
