//
//  TabBarController.swift
//  MKCinema
//
//  Created by Admin on 1/11/21.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTabBar()
    }
    
    private func setTabBar() {
        let storyboard = UIStoryboard(name: "List", bundle:nil)
        guard let filmsListVC = storyboard.instantiateViewController(identifier: "FilmsListViewController")
                as? FilmsListViewController else {
            
            return
        }
        let favouritesFilmsVC = FavouritesFilmsViewController()
        filmsListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 0)
        favouritesFilmsVC.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
        viewControllers = [filmsListVC, favouritesFilmsVC]
    }
    
}
