//
//  Restaurant.swift
//  dicoding
//
//  Created by Mochammad Arief Ridwan on 26/01/23.
//

import Foundation

struct ListResponse: Decodable {
  var error: Bool
  var message: String?
  var count: Int?
  var restaurants: [Restaurant]?
  
  init(error: Bool, message: String, count: Int, restaurants: [Restaurant]){
    self.error = error
    self.message = message
    self.count = count
    self.restaurants = restaurants
  }
}

struct Restaurant: Decodable {
  var id: String?
  var name: String?
  var description: String?
  var pictureId: String?
  var city: String?
  var rating: Double?
  
  init(id: String, name: String, description: String, pictureId: String, city: String, rating: Double) {
    self.id = id
    self.name = name
    self.description = description
    self.pictureId = pictureId
    self.city = city
    self.rating = rating
  }
}
