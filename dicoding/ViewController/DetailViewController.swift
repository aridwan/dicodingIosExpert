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
    private lazy var favoritesProvider: FavoritesProvider = { return FavoritesProvider() }()
    var isLiked: Bool = false
    var isCollectionViewHidden = false
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationItem()
        self.registerCell()
        self.loadRequest()
        self.collectionView.isHidden = isCollectionViewHidden
        self.gameTitleLabel.text = self.game?.name
        if let savedImageData = game?.savedImage {
          self.gameImageView.image = UIImage(data: savedImageData)
          self.activityIndicator.stopAnimating()
        } else {
          self.loadBigImage(urlString: self.game?.backgroundImage ?? "", imageView: self.gameImageView)
        }
        self.checkFavorites(id: game?.id ?? 0)
    }

  private func setNavigationItem() {
    self.title = self.game?.name ?? ""
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(likeTapped))
    navigationItem.rightBarButtonItem?.tintColor = UIColor.white
  }
  
  private func loadBigImage(urlString: String, imageView: UIImageView){
    guard let url = URL(string: urlString) else { return }
    imageView.load(url: url, activityIndicator: self.activityIndicator)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    self.tabBarController?.tabBar.isHidden = false
  }
  
  private func registerCell(){
    self.collectionView.register(cellType: GameImageCollectionViewCell.self)
  }
  
  private func loadRequest(){
    let params: [String: String] = [
      "key": Constants.APIKey
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
  
  func checkFavorites(id: Int){
    favoritesProvider.getGames(by: id) { member in
      DispatchQueue.main.async {
        if member.id != nil {
          self.fillHeart()
          self.isLiked = true
        } else {
          self.emptyHeart()
          self.isLiked = false
        }
      }
    }
  }
  
  @objc func likeTapped(){
    if !isLiked {
      guard let data = self.gameImageView.image?.pngData() else {return}
      favoritesProvider.createFavorites(id: game?.id ?? 0, name: game?.name ?? "", released_date: game?.released ?? "", rating: game?.rating ?? 0, added: game?.added ?? 0, esrb_rating: game?.esrbRating?.name?.rawValue ?? "", description_raw: game?.description_raw ?? "", image: data)
      self.fillHeart()
      self.isLiked = true
    } else {
      favoritesProvider.deleteFavorites(game?.id ?? 0)
      self.emptyHeart()
      self.isLiked = false
    }
  }
  
  fileprivate func fillHeart(){
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .plain, target: self, action: #selector(likeTapped))
    navigationItem.rightBarButtonItem?.tintColor = UIColor.white
  }
  
  fileprivate func emptyHeart(){
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(likeTapped))
    navigationItem.rightBarButtonItem?.tintColor = UIColor.white
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
