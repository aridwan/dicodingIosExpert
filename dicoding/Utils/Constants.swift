//
//  Constants.swift
//  dicoding
//
//  Created by Mochammad Arief Ridwan on 07/02/23.
//

import Foundation
import UIKit

struct Constants {
  
  struct Color {
    static let mainDarkGray = UIColor(red: 24.0, green: 24.0, blue: 24.0, alpha: 1.0)
    static let mainBlack = UIColor.black
  }
  
  static var APIKey: String {
    get {
      guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist") else {
            fatalError("Couldn't find file 'Info.plist'.")
          }
          let plist = NSDictionary(contentsOfFile: filePath)
          guard let value = plist?.object(forKey: "API_KEY") as? String else {
            fatalError("Couldn't find key 'API_KEY' in 'Info.plist'.")
          }
          return value
    }
  }
}
