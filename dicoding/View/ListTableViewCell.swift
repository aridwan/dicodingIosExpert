//
//  ListTableViewCell.swift
//  dicoding
//
//  Created by Mochammad Arief Ridwan on 26/01/23.
//

import UIKit
import Reusable
import Cosmos


class ListTableViewCell: UITableViewCell, NibReusable {
  
  @IBOutlet weak var listImage: UIImageView!
  @IBOutlet weak var listTitle: UILabel!
  @IBOutlet weak var cosmos: CosmosView!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  @IBOutlet weak var platformView: UIView!
  @IBOutlet weak var releaseDateLabel: UILabel!
  
  var game: Result? {
    didSet {
      self.removeAllSubviews(view: platformView)
      self.listTitle.text = self.game?.name
      self.activityIndicator.stopAnimating()
      self.cosmos.rating = self.game?.rating ?? 0.0
      self.releaseDateLabel.text = "Release date \(self.game?.released ?? "")"
      self.setPlatformIcon(platforms: game?.parentPlatforms ?? [ParentPlatform](), view: self.platformView)
      if let imageData = game?.savedImage {
        self.listImage.image = UIImage(data: imageData)
      }
    }
  }
  override func awakeFromNib() {
    super.awakeFromNib()
    self.activityIndicator.startAnimating()
    self.cosmos.settings.fillMode = .precise
  }
  
  private func removeAllSubviews(view: UIView){
    for item in view.subviews {
      item.removeFromSuperview()
    }
  }
    
  private func setPlatformIcon(platforms: [ParentPlatform], view: UIView) {
    var count = 0
    for item in platforms {
      let image = UIImage(named: item.platform?.slug?.rawValue ?? "")
      let imageView = UIImageView(frame: CGRect(x: (25 * count), y: 0, width: 17, height: 17))
      imageView.image = image
      view.addSubview(imageView)
      count += 1
    }
  }
}
