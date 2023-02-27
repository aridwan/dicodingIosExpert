//
//  GameImageCollectionViewCell.swift
//  dicoding
//
//  Created by Mochammad Arief Ridwan on 03/02/23.
//

import UIKit
import Reusable

class GameImageCollectionViewCell: UICollectionViewCell, NibReusable {

  @IBOutlet weak var imageView: UIImageView!
  
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
