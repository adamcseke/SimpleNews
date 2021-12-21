//
//  FeedViewController.swift
//  SimpleNews
//
//  Created by Adam Cseke on 2021. 11. 23..
//

import UIKit

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CellDelegate {
    
    private let tableView = UITableView(frame: .zero, style: .plain)
    var news: [Article] = []
    var query: String = "Apple"
    var country: String = "hu"
    var category: String = "business"
    var searchVC = UISearchController(searchResultsController: nil)
    let formatter = DateFormatter()
                                     
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getSavedFavorites()
        tableView.reloadData()
    }
    private func setup() {
        configureNavigationController()
        configureSearchController()
        configureTableView()
        getNews(country: country, category: category)
    }
    private func searchNews(query: String) {
        APICaller.shared.searchNews(query: query) { [weak self] result in
            switch result {
                
            case .success(let article):
                self?.news.append(contentsOf: article.articles)
                self?.getSavedFavorites()
                self?.tableView.reloadData()
                DataManager.shared.saveData(data: article, forKey: DataManager.Constants.searchResponseKey)
            case .failure(_):
                guard let article = DataManager.shared.getSavedData(type: NewsInfo.self, forKey: DataManager.Constants.searchResponseKey) else { return }
                self?.news = article.articles
                self?.getSavedFavorites()
                self?.tableView.reloadData()
            }
        }
    }
    private func getNews(country: String, category: String) {
        APICaller.shared.getNews(country: country, category: category) { [weak self] result in
            switch result {
                
            case .success(let article):
                self?.news.append(contentsOf: article.articles)
                self?.getSavedFavorites()
                self?.tableView.reloadData()
                DataManager.shared.saveData(data: article, forKey: DataManager.Constants.getNewsKey)
            case .failure(_):
                guard let article = DataManager.shared.getSavedData(type: NewsInfo.self, forKey: DataManager.Constants.getNewsKey) else { return }
                self?.news = article.articles
                self?.getSavedFavorites()
                self?.tableView.reloadData()
            }
        }
    }
    private func getSavedFavorites() {
        let favorites = DataManager.shared.getSavedData(type: [Article].self, forKey: DataManager.Constants.savedNewsFavorites)
        news.enumerated().forEach({ index, article in
            var newArticle = news[index]
            if favorites?.first(where: {$0.url == article.url}) != nil {
                newArticle.isFavorite = true
            } else {
                newArticle.isFavorite = false
            }
            news[index] = newArticle
        })
    }
    private func showAlertView() {
        let alertController = UIAlertController(title: "FeedScreen.AlertShow.title".localized,
                                                message: "FeedScreen.AlertShow.description".localized,
                                          preferredStyle: .alert)
        let okAction = UIAlertAction (title: "FeedScreen.AlertShow.buttonLabel".localized, style: .cancel, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
    private func configureNavigationController() {
        navigationItem.title = "FeedScreen.ControllerTitle".localized
        navigationController?.navigationBar.prefersLargeTitles = true
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.label]
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
    }
    private func configureSearchController() {
        searchVC.hidesNavigationBarDuringPresentation = true
        searchVC.searchBar.sizeToFit()
        searchVC.searchBar.placeholder = "FeedScreen.SearchBar.label".localized
        searchVC.automaticallyShowsCancelButton = true
        searchVC.obscuresBackgroundDuringPresentation = true
        searchVC.searchBar.delegate = self
        navigationItem.searchController = searchVC
    }
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "myCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.rowHeight = 200
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as? CustomTableViewCell else {
            fatalError()
        }
        let newsInfo = news[indexPath.row]
        let date = newsInfo.publishedAt
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        cell.bind(titleLabelText: newsInfo.title,
                  sourceLabelText: newsInfo.source.name ?? "",
                  dateLabelText: formatter.string(from: date),
                  backgroundImageURL: newsInfo.urlToImage ?? "",
                  indexPath: indexPath, delegate: self, isFavorite: newsInfo.isFavorite)
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    func buttonTapped(at indexPath: IndexPath) {
        news[indexPath.row].isFavorite.toggle()
        var favorites: [Article] = []
        news.forEach { article in
            if article.isFavorite == true {
                favorites.append(article)
            }
        }
        DataManager.shared.saveData(data: favorites, forKey: DataManager.Constants.savedNewsFavorites)
    }
}

extension FeedViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
        query = text
        news = []
        searchNews(query: text)
        searchVC.dismiss(animated: true, completion: nil)
    }
}
