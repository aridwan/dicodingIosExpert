//
//  ReviewTableViewCell.swift
//  dicoding
//
//  Created by Mochammad Arief Ridwan on 27/01/23.
//

import UIKit
import Reusable

class ReviewTableViewCell: UITableViewCell, NibReusable {

  @IBOutlet weak var collectionView: UICollectionView!
  
  var detailRestaurant: DetailRestaurant? {
    didSet {
      collectionView.reloadData()
    }
  }
  
    override func awakeFromNib() {
        super.awakeFromNib()
        self.registerCell()
    }

  private func registerCell() {
    self.collectionView.register(cellType: ReviewCollectionViewCell.self)
  }
  
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension ReviewTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 4
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: ReviewCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
    cell.review = detailRestaurant?.customerReviews?[indexPath.row]
    return cell
  }
 
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 286, height: 110)
  }
  
}
