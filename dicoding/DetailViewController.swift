//
//  DetailViewController.swift
//  dicoding
//
//  Created by Mochammad Arief Ridwan on 26/01/23.
//

import UIKit
import Alamofire
import Cosmos

class DetailViewController: UIViewController {
  
  @IBOutlet weak var gameImageView: UIImageView!
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var gameTitleLabel: UILabel!
  @IBOutlet weak var cosmos: CosmosView!
  @IBOutlet weak var addedLabel: UILabel!
  @IBOutlet weak var esrbRatingLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  var game: Result?
  var detailGame: DetailGame?
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationItem()
        self.registerCell()
        self.loadRequest()
        self.gameTitleLabel.text = self.game?.name
        self.loadBigImage(urlString: self.game?.backgroundImage ?? "", imageView: self.gameImageView)
    }

  private func setNavigationItem() {
    self.title = self.game?.name ?? ""
  }
  
  private func loadBigImage(urlString: String, imageView: UIImageView){
    guard let url = URL(string: urlString) else { return }
    imageView.load(url: url, activityIndicator: self.activityIndicator)
  }
  
  private func registerCell(){
    self.collectionView.register(cellType: GameImageCollectionViewCell.self)
  }
  
  private func loadRequest(){
    
    let params: [String: String] = [
      "key": "690ab7b3ef554367afeff7592b36b40e"
    ]
    
    AF.request("\(Endpoint.listGame)/\(self.game?.id ?? 0)", parameters: params).responseDecodable (of: DetailGame.self) { response in
      switch response.result{
      case .success(let types):
        
        self.descriptionLabel.text = types.descriptionRaw
        self.esrbRatingLabel.text = types.esrbRating?.name?.rawValue
        self.addedLabel.text = String(types.added ?? 0)
        self.cosmos.rating = types.rating ?? 0.0
      case .failure(let error):
        print(error)
      }
    }
  }
  
  private func setGameComponents(gameDetail: DetailGame){
    
  }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.game?.shortScreenshots?.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: GameImageCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
    guard let imageUrl = URL(string: self.game?.shortScreenshots?[indexPath.row].image ?? "") else { return cell}
    cell.imageView.load(url: imageUrl)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let imageUrl = URL(string: self.game?.shortScreenshots?[indexPath.row].image ?? "") else {return}
    self.gameImageView.load(url: imageUrl, activityIndicator: self.activityIndicator)
  }
}
