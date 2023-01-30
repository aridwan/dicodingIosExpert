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
  
  var restaurants = [Restaurant]()
  
    override func viewDidLoad() {
      super.viewDidLoad()
      self.registerCell()
      self.setNavigationItem()
      self.callApi()
      
      table.reloadData()
    }
  
  private func registerCell(){
    self.table.register(cellType: ListTableViewCell.self)
  }
  
  private func callApi(){
    AF.request(Endpoint.listRestaurant).responseDecodable (of: ListResponse.self) { response in
      switch response.result{
      case .success(let types):
        self.restaurants = types.restaurants ?? [Restaurant]()
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
    self.title = "Restaurant"
  }
  
  @objc func profileTapped(){
    let viewController = ProfileViewController()
    self.navigationController?.pushViewController(viewController, animated: true)
  }
  
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return restaurants.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: ListTableViewCell = table.dequeueReusableCell(for: indexPath)
    cell.restaurant = self.restaurants[indexPath.row]
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let viewController = DetailViewController()
    viewController.restaurant = self.restaurants[indexPath.row]
    self.navigationController?.pushViewController(viewController, animated: true)
  }
  
}
