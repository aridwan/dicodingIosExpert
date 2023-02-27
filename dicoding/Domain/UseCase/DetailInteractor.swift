//
//  DetailInteractor.swift
//  dicoding
//
//  Created by Mochammad Arief Ridwan on 20/02/23.
//

import Foundation
import UIKit

protocol DetailUseCase {

  func getDetailGame(game: Game, completion: @escaping (Result<DetailGame, Error>) -> Void)
  func setFavorites(game: Game, image: Data, completion: @escaping (Result<Bool, Error>) -> Void)
  func removeFavorites(game: Game, completion: @escaping (Result<Bool, Error>) -> Void)
  func checkFavorites(id: Int, completion: @escaping (Result<Game, Error>) -> Void)
  func deleteAll()
}

class DetailInteractor: DetailUseCase {

  private let repository: GameRepositoryProtocol
  private let game: Game?
  private lazy var favoritesProvider: FavoritesProvider = { return FavoritesProvider() }()

  required init(
    repository: GameRepositoryProtocol,
    game: Game
  ) {
    self.repository = repository
    self.game = game
  }

  func getDetailGame(game: Game, completion: @escaping (Result<DetailGame, Error>) -> Void) {
    repository.getDetailGame(game: game) { result in
      completion(result)
    }
  }
  
  func setFavorites(game: Game, image: Data, completion: @escaping (Result<Bool, Error>) -> Void) {
    repository.addFavoriteGame(game: game, image: image) { result in
      completion(result)
    }
  }
  
  func removeFavorites(game: Game, completion: @escaping (Result<Bool, Error>) -> Void) {
    repository.removeFavoriteGame(game: game) { result in
      completion(result)
    }
  }

  func checkFavorites(id: Int, completion: @escaping (Result<Game, Error>) -> Void) {
    repository.checkFavorites(id: id) { result in
      completion(result)
    }
  }
  
  func deleteAll() {
    repository.deleteAll()
  }
}
