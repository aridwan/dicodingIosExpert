//
//  UIImageView.swift
//  dicoding
//
//  Created by Mochammad Arief Ridwan on 26/01/23.
//

import UIKit

extension UIImageView{
  func load(url: URL) {
      DispatchQueue.global().async {
          if let data = try? Data(contentsOf: url) {
              if let image = UIImage(data: data) {
                  DispatchQueue.main.async {
                      self.image = image
                  }
              }
          }
      }
  }
}
