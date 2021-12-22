//
//  AboutViewController.swift
//  SimpleNews
//
//  Created by Adam Cseke on 2021. 11. 29..
//

import UIKit

class AboutViewController: UIViewController {
    
    private let titleLabel = UILabel()
    private let logoButton = UIButton()
    private let creatorLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    private func setup() {
        configureNavigationController()
        configureTitleLabel()
        configureLogoButton()
        configureCreatorLabel()
    }
    private func configureNavigationController() {
        navigationItem.title = "AboutScreen.ControllerTitle".localized
        view.backgroundColor = .systemBackground
    }
    private func configureTitleLabel() {
        titleLabel.text = "AboutScreen.AppTitle".localized
        titleLabel.textColor = .label
        titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 75),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -75)
        ])
    }
    private func configureLogoButton() {
        logoButton.setImage(UIImage(named: "appIconButton"), for: .normal)
        logoButton.layer.cornerRadius = 40
        logoButton.layer.masksToBounds = true
        logoButton.translatesAutoresizingMaskIntoConstraints = false
        logoButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        view.addSubview(logoButton)
        
        NSLayoutConstraint.activate([
            logoButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            logoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoButton.heightAnchor.constraint(equalToConstant: 150),
            logoButton.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    @objc func didTapButton() {
        if let url = URL(string: "https://github.com/adamcseke") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    private func configureCreatorLabel() {
        creatorLabel.text = "AboutScreen.CreatorLabel".localized
        creatorLabel.numberOfLines = 2
        creatorLabel.textColor = .secondaryLabel
        creatorLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        creatorLabel.translatesAutoresizingMaskIntoConstraints = false
        creatorLabel.textAlignment = .center
        view.addSubview(creatorLabel)
        
        NSLayoutConstraint.activate([
            creatorLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            creatorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 110),
            creatorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -110)
        ])
    }
}
