//
//  Category.swift
//  dicoding
//
//  Created by Mochammad Arief Ridwan on 27/01/23.
//

import Foundation

struct Category: Decodable {
  var name: String?
  
  init(name: String) {
    self.name = name
  }
}
