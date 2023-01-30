//
//  ListTableViewCell.swift
//  dicoding
//
//  Created by Mochammad Arief Ridwan on 26/01/23.
//

import UIKit
import Reusable


class ListTableViewCell: UITableViewCell, NibReusable {
  
  @IBOutlet weak var listImage: UIImageView!
  @IBOutlet weak var listTitle: UILabel!
  @IBOutlet weak var listDescription: UILabel!
  
  var restaurant: Restaurant? {
    didSet {
      self.listTitle.text = self.restaurant?.name
      self.listDescription.text = self.restaurant?.description
      guard let url = URL(string: Endpoint.smallImageRestaurant + (self.restaurant?.pictureId ?? "")) else { return }
      self.listImage.load(url: url)
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
