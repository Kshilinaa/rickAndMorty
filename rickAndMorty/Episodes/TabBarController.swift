//
//  TabBarController.swift
//  rickAndMorty
//
//  Created by Ксения Шилина on 10.11.2023.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let homeViewController = EpisodesViewController() 
        let favoritesViewController = FavoritesViewController()

        homeViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "house"), tag: 0)
        favoritesViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "heart"), tag: 1)
        
        tabBar.tintColor = UIColor(named: "tabBarColor")

        viewControllers = [homeViewController, favoritesViewController]
    }
}
