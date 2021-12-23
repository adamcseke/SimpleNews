//
//  CustomTabBarController.swift
//  SimpleNews
//
//  Created by Adam Cseke on 2021. 11. 30..
//

import UIKit

class TabBarController: UITabBarController {

    private let generator = UIImpactFeedbackGenerator(style: .medium)
    
    private let feedVC = NavigationController(rootViewController: FeedViewController())
    private let favoritesVC = NavigationController(rootViewController: FavoritesViewController())
    private let aboutVC = NavigationController(rootViewController: AboutViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemOrange
        setup()
        viewControllers = [feedVC, favoritesVC, aboutVC]
    }
    private func setup() {
        setupFeedVC()
        setupFavoritesVC()
        setupAboutVC()
    }
    private func setupFeedVC() {
        feedVC.tabBarItem = UITabBarItem(title: "Feed".localized, image: UIImage(systemName: "book"), tag: 0)
        feedVC.tabBarItem.selectedImage = UIImage(systemName: "book.fill")
    }
    private func setupFavoritesVC() {
        favoritesVC.tabBarItem = UITabBarItem(title: "Favorites".localized, image: UIImage(systemName: "bookmark"), tag: 1)
        favoritesVC.tabBarItem.selectedImage = UIImage(systemName: "bookmark.fill")
    }
    private func setupAboutVC() {
        aboutVC.tabBarItem = UITabBarItem(title: "About".localized, image: UIImage(systemName: "person"), tag: 2)
        aboutVC.tabBarItem.selectedImage = UIImage(systemName: "person.fill")
    }
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        generator.impactOccurred()
    }
}
