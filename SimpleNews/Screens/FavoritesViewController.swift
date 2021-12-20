//
//  FavoritesViewController.swift
//  SimpleNews
//
//  Created by Adam Cseke on 2021. 11. 29..
//

import UIKit
import Lottie

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CellDelegate {
    
    private let noBookmarksLabel = UILabel()
    private let emptyAnimationView = AnimationView(name: "bookmarkAnimation")
    private let tableView = UITableView()
    private var favorites: [Article] = [] {
        didSet {
            emptyAnimationView.isHidden = !favorites.isEmpty
            noBookmarksLabel.isHidden = !favorites.isEmpty
            playAnimationIfNeeded()
            tableView.reloadData()
        }
    }
    private let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        if favorites.isEmpty == true {
            setupEmptyAnimation()
        } else {
            configureTableView()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getSavedFavorites()
        playAnimationIfNeeded()
    }
    private func setup() {
        configureNavigationController()
        configureTableView()
        setupEmptyAnimation()
        configureNoBookmarksLabel()
    }
    private func getSavedFavorites() {
        guard let favorites = DataManager.shared.getSavedData(type: [Article].self, forKey: DataManager.Constants.savedNewsFavorites) else {
            return
        }
        self.favorites = favorites
    }
    private func configureNavigationController() {
        navigationItem.title = "FavoritesScreen.ControllerTitle".localized
        view.backgroundColor = .systemBackground
    }
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "myCell")
        tableView.separatorStyle = .none
        tableView.rowHeight = 200
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as? CustomTableViewCell else {
            fatalError()
        }
        let newsInfo = favorites[indexPath.row]
        let date = newsInfo.publishedAt
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        cell.bind(titleLabelText: newsInfo.title,
                  sourceLabelText: newsInfo.source.name ?? "",
                  dateLabelText: formatter.string(from: date),
                  backgroundImageURL: newsInfo.urlToImage ?? "",
                  indexPath: indexPath,
                  delegate: self,
                  isFavorite: newsInfo.isFavorite)
        return cell
    }
    private func configureNoBookmarksLabel() {
        noBookmarksLabel.translatesAutoresizingMaskIntoConstraints = false
        noBookmarksLabel.text = "FavoritesScreen.NoBookmarksLabel".localized
        noBookmarksLabel.textColor = .secondaryLabel
        view.addSubview(noBookmarksLabel)
        
        NSLayoutConstraint.activate([
            noBookmarksLabel.topAnchor.constraint(equalTo: emptyAnimationView.bottomAnchor),
            noBookmarksLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    private func setupEmptyAnimation() {
        emptyAnimationView.isHidden = true
        emptyAnimationView.frame = view.bounds
        emptyAnimationView.contentMode = .scaleAspectFit
        emptyAnimationView.loopMode = .loop
        emptyAnimationView.animationSpeed = 1
        emptyAnimationView.play()
        emptyAnimationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emptyAnimationView)
        
        NSLayoutConstraint.activate([
            emptyAnimationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyAnimationView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyAnimationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyAnimationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    func buttonTapped(at indexPath: IndexPath) {
        favorites[indexPath.row].isFavorite.toggle()
        var newFavorites: [Article] = []
        favorites.forEach { article in
            if article.isFavorite == true {
                newFavorites.append(article)
            }
        }
        DataManager.shared.saveData(data: newFavorites, forKey: DataManager.Constants.savedNewsFavorites)
    }
    
    private func playAnimationIfNeeded() {
        if favorites.isEmpty {
            emptyAnimationView.play()
        } else {
            emptyAnimationView.pause()
        }
    }
}
