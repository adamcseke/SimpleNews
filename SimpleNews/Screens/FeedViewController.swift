//
//  FeedViewController.swift
//  SimpleNews
//
//  Created by Adam Cseke on 2021. 11. 30..
//

import UIKit

class FeedViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    private func setup() {
        configureNavigationController()
    }
    private func configureNavigationController() {
        navigationItem.title = "Feed"
        view.backgroundColor = .systemBackground
    }
    
}
