//
//  TabBarViewController.swift
//  dicoding
//
//  Created by Mochammad Arief Ridwan on 07/02/23.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
      view.backgroundColor = Constants.Color.mainBlack
        UITabBar.appearance().barTintColor = UIColor.black
        UITabBar.appearance().backgroundColor = UIColor.black
        self.tabBar.isTranslucent = false
        tabBar.tintColor = .white
        setupVCs()
    }

  func setupVCs() {
    guard let gamesImage = UIImage(systemName: "gamecontroller.fill"), let favoritesImage = UIImage(systemName: "star.fill") else {return}
        viewControllers = [
            createNavController(for: ListViewController(), title: NSLocalizedString("Games", comment: ""), image: gamesImage),
            createNavController(for: FavoritesViewController(), title: NSLocalizedString("Favorites", comment: ""), image: favoritesImage)
        ]
    }
  
  fileprivate func createNavController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationItem.title = title
        return navController
    }
  
}
