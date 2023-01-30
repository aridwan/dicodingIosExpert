//
//  Review.swift
//  dicoding
//
//  Created by Mochammad Arief Ridwan on 27/01/23.
//

import Foundation

struct Review: Decodable {
  var name: String?
  var review: String?
  var date: String?
  
  init(name: String, review: String, date: String) throws {
    self.name = name
    self.review = review
    self.date = date
  }
}
