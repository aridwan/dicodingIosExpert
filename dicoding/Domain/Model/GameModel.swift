//
//  GameModel.swift
//  dicoding
//
//  Created by Mochammad Arief Ridwan on 20/02/23.
//

import Foundation
import UIKit

struct GameModel {

  var id: Int?
  var slug, name, released: String?
  var backgroundImage: String?
  var rating: Double?
  var added: Int?
  var reviewsCount: Int?
  var parentPlatforms: [ParentPlatform]?
  var esrbRating: EsrbRating?
  var shortScreenshots: [ShortScreenshot]?
  var descriptionRaw: String?
  var state: DownloadState = .new
  var savedImage: Data?
  var image: UIImage?
}
