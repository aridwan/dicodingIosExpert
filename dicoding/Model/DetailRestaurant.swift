//
//  DetailRestaurant.swift
//  dicoding
//
//  Created by Mochammad Arief Ridwan on 27/01/23.
//

import Foundation

struct DetailRestaurant: Decodable {
  var id: String?
  var name: String?
  var description: String?
  var pictureId: String?
  var city: String?
  var rating: Double?
  var address: String?
  var categories: [Category]?
  var menus: Menu?
  var customerReviews: [Review]?
  
  
  init(id: String, name: String, description: String, pictureId: String, city: String, rating: Double, address: String?, categories: [Category], menus: Menu, customerReviews: [Review]) {
    self.id = id
    self.name = name
    self.description = description
    self.pictureId = pictureId
    self.city = city
    self.rating = rating
    self.address = address
    self.categories = categories
    self.menus = menus
    self.customerReviews = customerReviews
  }
}

struct DetailRestaurantResponse: Decodable {
  var error: Bool
  var message: String?
  var restaurant: DetailRestaurant?
  
  init(error: Bool, message: String, restaurant: DetailRestaurant) {
    self.error = error
    self.message = message
    self.restaurant = restaurant
  }
}
