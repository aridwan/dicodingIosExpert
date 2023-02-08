//
//  FavoritesViewController.swift
//  dicoding
//
//  Created by Mochammad Arief Ridwan on 07/02/23.
//

import UIKit

class FavoritesViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  
  private lazy var favoritesProvider: FavoritesProvider = { return FavoritesProvider() }()
  var favorites = [Result]()
  
  override func viewDidLoad() {
      super.viewDidLoad()
      self.setNavigationItem()
      self.registerCell()
    }
  
  override func viewDidAppear(_ animated: Bool) {
    self.getAllFavorites()
  }

  func setNavigationItem(){
    self.title = "Favorites"
    self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
  }
  
  func registerCell(){
    self.tableView.register(cellType: ListTableViewCell.self)
  }
  
  func getAllFavorites(){
    favoritesProvider.getAllFavorites() { games in
      DispatchQueue.main.async {
        if games.isEmpty {
          self.tableView.isHidden = true
        } else {
          self.tableView.isHidden = false
        }
        self.favorites = games
        self.tableView.reloadData()
      }
    }
  }
  
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return favorites.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: ListTableViewCell = tableView.dequeueReusableCell(for: indexPath)
    cell.game = self.favorites[indexPath.row]
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let viewController = DetailViewController()
    viewController.game = self.favorites[indexPath.row]
    viewController.isCollectionViewHidden = true
    self.tabBarController?.tabBar.isHidden = true
    self.navigationController?.pushViewController(viewController, animated: true)
  }
}
