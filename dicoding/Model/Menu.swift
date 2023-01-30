//
//  Menu.swift
//  dicoding
//
//  Created by Mochammad Arief Ridwan on 27/01/23.
//

import Foundation

struct Menu: Decodable {
  var foods: [Food]?
  var drinks: [Drinks]?
  
  init(foods: [Food], drinks: [Drinks]) {
    self.foods = foods
    self.drinks = drinks
  }
}

struct Food: Decodable {
  var name: String?
  
  init(name: String) {
    self.name = name
  }
}

struct Drinks: Decodable {
  var name: String?
  
  init(name: String) {
    self.name = name
  }
}
