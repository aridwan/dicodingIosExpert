//
//  DetailImageTableViewCell.swift
//  dicoding
//
//  Created by Mochammad Arief Ridwan on 27/01/23.
//

import UIKit
import Reusable

class DetailImageTableViewCell: UITableViewCell, NibReusable {

  @IBOutlet weak var restaurantLargeImage: UIImageView!
  
  var pictureId: String? {
    didSet {
      guard let url = URL(string: Endpoint.largeImageRestaurant + (self.pictureId ?? "")) else { return }
      restaurantLargeImage.load(url: url)
    }
  }
  
    override func awakeFromNib() {
      super.awakeFromNib()
    }
}
