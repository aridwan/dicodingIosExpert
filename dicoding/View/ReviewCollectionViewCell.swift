//
//  ReviewCollectionViewCell.swift
//  dicoding
//
//  Created by Mochammad Arief Ridwan on 27/01/23.
//

import UIKit
import Reusable

class ReviewCollectionViewCell: UICollectionViewCell, NibReusable {

  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var commentLabel: UILabel!
  
  var review: Review? {
    didSet {
      nameLabel.text = review?.name ?? ""
      dateLabel.text = review?.date ?? ""
      commentLabel.text = review?.review ?? ""
    }
  }
  
  override func awakeFromNib() {
        super.awakeFromNib()
    
    }

}
