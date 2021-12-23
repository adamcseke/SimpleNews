//
//  NavigationController.swift
//  SimpleNews
//
//  Created by Adam Cseke on 2021. 11. 30..
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    private func setup() {
        configureNavigationController()
    }
    private func configureNavigationController() {
        navigationBar.prefersLargeTitles = true
        navigationBar.backgroundColor = .systemBackground
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.label]
        navigationBar.largeTitleTextAttributes = attributes
    }
}
