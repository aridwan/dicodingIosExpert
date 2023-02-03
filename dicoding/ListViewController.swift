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
  
  var games = [Result]()
  
    override func viewDidLoad() {
      super.viewDidLoad()
      self.registerCell()
      self.setNavigationItem()
      Task { await self.callApi(page: "1") }
      
      table.reloadData()
    }
  
  private func registerCell(){
    self.table.register(cellType: ListTableViewCell.self)
  }
  
  private func callApi(page: String) async{
    let params: [String: String] = [
      "key": "690ab7b3ef554367afeff7592b36b40e",
      "page": page,
      "page_size": "15"
    ]
    AF.request(Endpoint.listGame, parameters: params).validate().responseDecodable(of: ListGame.self) { response in
      switch response.result{
      case .success(let types):
        self.games = types.results ?? [Result]()
        self.table.reloadData()
      case .failure(let error):
        print(error)
      }
    }
  }

  private func setNavigationItem(){
    if #available(iOS 11.0, *) {
      self.navigationController?.navigationBar.prefersLargeTitles = true
      self.navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .plain, target: self, action: #selector(profileTapped))
    self.title = "Games By RAWG"
    self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
  }
  
  @objc func profileTapped(){
    let viewController = ProfileViewController()
    self.navigationController?.pushViewController(viewController, animated: true)
  }
  
  fileprivate func startDownload(game: Result, indexPath: IndexPath) {
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
    return games.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: ListTableViewCell = table.dequeueReusableCell(for: indexPath)
    let game = games[indexPath.row]
    cell.listImage.image = game.image
    cell.game = game
    if games[indexPath.row].state == .new {
      startDownload(game: games[indexPath.row], indexPath: indexPath)
      }
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let viewController = DetailViewController()
    viewController.game = self.games[indexPath.row]
    self.navigationController?.pushViewController(viewController, animated: true)
  }
  
}
