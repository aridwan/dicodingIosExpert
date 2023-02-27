//
//  FavoritesViewController.swift
//  dicoding
//
//  Created by Mochammad Arief Ridwan on 07/02/23.
//

import UIKit

class FavoritesViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  var presenter: HomePresenter?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let homeUseCase = Injection.init().provideHome()
    self.presenter = HomePresenter.init(homeUseCase: homeUseCase)
    self.setNavigationItem()
    self.registerCell()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    self.presenter?.getAllFavorites(completion: {
      if self.presenter?.games.count == 0 {
        self.tableView.isHidden = true
      } else {
        self.tableView.isHidden = false
      }
      self.tableView.reloadData()
    })
  }
  
  func setNavigationItem() {
    self.title = "Favorites"
    self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
  }
  
  func registerCell() {
    self.tableView.register(cellType: ListTableViewCell.self)
  }
  
//  func getAllFavorites() {
//    favoritesProvider.getAllFavorites { games in
//      DispatchQueue.main.async {
//        if games.isEmpty {
//          self.tableView.isHidden = true
//        } else {
//          self.tableView.isHidden = false
//        }
//        self.favorites = games
//        self.tableView.reloadData()
//      }
//    }
//  }
  
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.presenter?.games.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: ListTableViewCell = tableView.dequeueReusableCell(for: indexPath)
    cell.game = self.presenter?.games[indexPath.row]
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    let viewController = DetailViewController()
//    viewController.isCollectionViewHidden = true
//    self.tabBarController?.tabBar.isHidden = true
//    self.navigationController?.pushViewController(viewController, animated: true)
    guard let game = self.presenter?.games[indexPath.row] else { return }
    self.presenter?.goToDetail(with: game, navigationController: self.navigationController ?? UINavigationController())
  }
}
