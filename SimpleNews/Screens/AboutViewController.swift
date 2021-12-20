//
//  AboutViewController.swift
//  SimpleNews
//
//  Created by Adam Cseke on 2021. 11. 29..
//

import UIKit

class AboutViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    private func setup() {
        configureNavigationController()
    }
    private func configureNavigationController() {
        navigationItem.title = "AboutScreen.ControllerTitle".localized
        view.backgroundColor = .systemBackground
    }
}
