//
//  FavoritesViewController.swift
//  SimpleNews
//
//  Created by Adam Cseke on 2021. 11. 29..
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CellDelegate {

    private let tableView = UITableView()
    private var favorites: [Article] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    private let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getSavedFavorites()
    }
    private func setup() {
        configureNavigationController()
        configureTableView()
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newsDetailVC = NewsDetailViewController(selectedNews: favorites[indexPath.row])
        navigationController?.pushViewController(newsDetailVC, animated: true)
    }
}
