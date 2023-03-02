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
    
    let listVC = ListViewController()
    let favoritesVC = FavoritesViewController()
    
    let homeUseCase = Injection.init().provideHome()
    let presenter = HomePresenter.init(homeUseCase: homeUseCase)
    let favoritesPresenter = HomePresenter.init(homeUseCase: homeUseCase)
    
    favoritesVC.presenter = favoritesPresenter
    listVC.presenter = presenter
        viewControllers = [
            createNavController(for: listVC, title: NSLocalizedString("Games", comment: ""), image: gamesImage),
            createNavController(for: favoritesVC, title: NSLocalizedString("Favorites", comment: ""), image: favoritesImage)
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
