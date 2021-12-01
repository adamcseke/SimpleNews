//
//  CustomTabBarController.swift
//  SimpleNews
//
//  Created by Adam Cseke on 2021. 11. 30..
//

import UIKit

class TabBarController: UITabBarController {
    
    private let feedVC = NavigationController(rootViewController: FeedViewController())
    private let favoritesVC = NavigationController(rootViewController: FavoritesViewController())
    private let aboutVC = NavigationController(rootViewController: AboutViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().tintColor = .systemOrange

        feedVC.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "book"), tag: 0)
        feedVC.tabBarItem.selectedImage = UIImage(systemName: "book.fill")
        
        favoritesVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "bookmark"), tag: 1)
        favoritesVC.tabBarItem.selectedImage = UIImage(systemName: "bookmark.fill")
        
        aboutVC.tabBarItem = UITabBarItem(title: "About", image: UIImage(systemName: "person"), tag: 2)
        aboutVC.tabBarItem.selectedImage = UIImage(systemName: "person.fill")
        
        viewControllers = [feedVC, favoritesVC, aboutVC]
    }
}
