//
//  DetailInformationTableViewCell.swift
//  dicoding
//
//  Created by Mochammad Arief Ridwan on 27/01/23.
//

import UIKit
import Reusable
import Cosmos

class DetailInformationTableViewCell: UITableViewCell, NibReusable {

  @IBOutlet weak var addressLabel: UILabel!
  @IBOutlet weak var cosmos: CosmosView!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var foodsLabel: UILabel!
  @IBOutlet weak var drinksLabel: UILabel!
  
  var detailRestaurant: DetailRestaurant? {
    didSet {
      addressLabel.text = "\(detailRestaurant?.address ?? ""), \(detailRestaurant?.city ?? "")"
      cosmos.rating = detailRestaurant?.rating ?? 0
      descriptionLabel.text = detailRestaurant?.description ?? ""
      foodsLabel.text = setLabelFromArray(array: detailRestaurant?.menus?.foods ?? [Food]())
      drinksLabel.text = setLabelFromArray(array: detailRestaurant?.menus?.drinks ?? [Drinks]())
    }
  }
  
    override func awakeFromNib() {
        super.awakeFromNib()
        cosmos.settings.fillMode = .precise
    }
    
  private func setLabelFromArray(array: [Food]) -> String{
    if !array.isEmpty {
      var initialArray = array
      initialArray.removeLast()
      var initialString = ""
      for array in initialArray {
        initialString += "\(array.name ?? ""), "
      }
      initialString += array.last?.name ?? ""
      return initialString
    } else {
      return ""
    }
  }
  
  private func setLabelFromArray(array: [Drinks]) -> String{
    if !array.isEmpty {
      var initialArray = array
      initialArray.removeLast()
      var initialString = ""
      for array in initialArray {
        initialString += "\(array.name ?? ""), "
      }
      initialString += array.last?.name ?? ""
      return initialString
    } else {
      return ""
    }
  }
}
