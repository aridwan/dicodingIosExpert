//
//  DetailViewController.swift
//  dicoding
//
//  Created by Mochammad Arief Ridwan on 26/01/23.
//

import UIKit
import Alamofire

class DetailViewController: UIViewController {
  
  @IBOutlet weak var table: UITableView!
  
  var restaurant: Restaurant?
  var detailRestaurant: DetailRestaurant?
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationItem()
        self.registerCell()
        self.loadRequest()
    }

  private func setNavigationItem() {
    self.title = self.restaurant?.name ?? ""
  }
  
  private func registerCell(){
    self.table.register(cellType: DetailImageTableViewCell.self)
    self.table.register(cellType: DetailInformationTableViewCell.self)
  }
  
  private func loadRequest(){
    AF.request(Endpoint.detailRestaurant + (self.restaurant?.id ?? "")).responseDecodable (of: DetailRestaurantResponse.self) { response in
      switch response.result{
      case .success(let types):
        self.detailRestaurant = types.restaurant
        self.table.reloadData()
      case .failure(let error):
        print(error)
      }
    }
  }
  
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.row {
    case 0:
      let cell: DetailImageTableViewCell = table.dequeueReusableCell(for: indexPath)
      cell.pictureId = self.restaurant?.pictureId ?? ""
      return cell
    default:
      let cell: DetailInformationTableViewCell = table.dequeueReusableCell(for: indexPath)
      cell.detailRestaurant = self.detailRestaurant
      return cell
    }
  }
  
  
}
