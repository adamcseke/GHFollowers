//
//  TabbarController.swift
//  GHFollowers
//
//  Created by Adam Cseke on 2022. 02. 07..
//

import UIKit

class TabbarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        UITabBar.appearance().barTintColor = .systemBackground
        UITabBar.appearance().isOpaque = true
        UITabBar.appearance().tintColor = .black
        if #available(iOS 15.0, *) {
           tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        }
        viewControllers = [createSearchNC(), createFavoritesNC()]
    }
    
    private func createSearchNC() -> NavigationController {
        let searchVC = SearchViewController()
        searchVC.tabBarItem = UITabBarItem(title: "TabbarController.SearchVC.Title".localized, image: UIImage(systemName: "magnifyingglass"), tag: 0)
        return NavigationController(rootViewController: searchVC)
    }
    
    private func createFavoritesNC() -> NavigationController {
        let favorites = FavoritesViewController()
        favorites.title = "TabbarController.FavoritesVC.Title".localized
        favorites.tabBarItem = UITabBarItem(title: "TabbarController.FavoritesVC.Title".localized, image: UIImage(systemName: "star.fill"), tag: 0)
        
        return NavigationController(rootViewController: favorites)
    }
    
}
