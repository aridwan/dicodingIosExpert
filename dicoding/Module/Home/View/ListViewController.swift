//
//  ListViewController.swift
//  dicoding
//
//  Created by Mochammad Arief Ridwan on 26/01/23.
//

import UIKit
import Alamofire

class ListViewController: UIViewController {

  @IBOutlet weak var table: UITableView!
  
  var presenter: HomePresenter?
//  var games = [Game]()
  
    override func viewDidLoad() {
      super.viewDidLoad()
      let homeUseCase = Injection.init().provideHome()
      self.presenter = HomePresenter.init(homeUseCase: homeUseCase)
      self.registerCell()
      self.setNavigationItem()
      self.presenter?.getGames {
        self.table.reloadData()
      }
    }
  
  private func registerCell() {
    self.table.register(cellType: ListTableViewCell.self)
  }

  private func setNavigationItem() {
    if #available(iOS 11.0, *) {
      self.navigationController?.navigationBar.prefersLargeTitles = true
      self.navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .plain, target: self, action: #selector(profileTapped))
    navigationItem.rightBarButtonItem?.tintColor = UIColor.white
    self.title = "Games"
    self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
  }
  
  @objc func profileTapped() {
    let viewController = ProfileViewController()
    self.navigationController?.pushViewController(viewController, animated: true)
  }
  
  func startDownload(game: Game, indexPath: IndexPath) {
      let imageDownloader = ImageDownloader()
      if game.state == .new {
        Task {
          do {
            guard let url = URL(string: game.backgroundImage ?? "") else { return }
            let image = try await imageDownloader.downloadImage(url: url)
            game.state = .downloaded
            game.image = image
            self.table.reloadRows(at: [indexPath], with: .automatic)
          } catch {
            game.state = .failed
            game.image = nil
          }
        }
      }
    }
  
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.presenter?.games.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: ListTableViewCell = table.dequeueReusableCell(for: indexPath)
    guard let game = self.presenter?.games[indexPath.row] else {return cell}
    cell.listImage.image = game.image
    cell.game = game
    if self.presenter?.games[indexPath.row].state == .new {
      
      startDownload(game: game, indexPath: indexPath)
      }
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let game = self.presenter?.games[indexPath.row] else { return }
    self.presenter?.goToDetail(with: game, navigationController: self.navigationController ?? UINavigationController())
//    let viewController = DetailViewController()
//    viewController.game = self.presenter.games?[indexPath.row]
//    self.tabBarController?.tabBar.isHidden = true
//    self.navigationController?.pushViewController(viewController, animated: true)
  }
  
}
