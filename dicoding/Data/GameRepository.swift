//
//  GameRepository.swift
//  dicoding
//
//  Created by Mochammad Arief Ridwan on 18/02/23.
//

import Foundation
import UIKit

protocol GameRepositoryProtocol {
  
  func getGames(result: @escaping (Result<[Game], Error>) -> Void)
  func getDetailGame(game: Game, result: @escaping (Result<DetailGame, Error>) -> Void)
  func addFavoriteGame(game: Game, image: Data, result: @escaping (Result<Bool, Error>) -> Void)
  func removeFavoriteGame(game: Game, result: @escaping (Result<Bool, Error>) -> Void)
  func checkFavorites(id: Int, result: @escaping (Result<Game, Error>) -> Void)
  func deleteAll()
  func getFavorites(result: @escaping (Result<[Game], Error>) -> Void)
}

final class GameRepository: NSObject {
  
  typealias GameInstance = (RemoteDataSource, FavoritesProvider) -> GameRepository
  
  fileprivate let remote: RemoteDataSource
  fileprivate let locale: FavoritesProvider
  
  private init(remote: RemoteDataSource, locale: FavoritesProvider) {
    self.remote = remote
    self.locale = locale
  }
  
  static let sharedInstance: GameInstance = { remoteRepo, localRepo in
    return GameRepository(remote: remoteRepo, locale: localRepo)
  }
  
}

extension GameRepository: GameRepositoryProtocol {
  func getGames(result: @escaping (Result<[Game], Error>) -> Void) {
    remote.getGames { response in
      switch response {
      case (.success(let gameResponses)):
        result(.success(gameResponses))
      case .failure(let error):
        result(.failure(error))
      }
      
    }
  }

  func getDetailGame(game: Game, result: @escaping (Result<DetailGame, Error>) -> Void) {
    remote.getDetailGame(game: game) { response in
      switch response {
      case (.success(let gameResponse)):
        result(.success(gameResponse))
      case .failure(let error):
        result(.failure(error))
      }
      
    }
  }

  func addFavoriteGame(game: Game, image: Data, result: @escaping (Result<Bool, Error>) -> Void) {
    locale.createFavorites(id: game.id ?? 0,
                           name: game.name ?? "",
                           releasedDate: game.released ?? "",
                           rating: game.rating ?? 0,
                           added: game.added ?? 0,
                           esrbRating: game.esrbRating?.name?.rawValue ?? "",
                           descriptionRaw: game.descriptionRaw ?? "",
                           image: image) { response in
      switch response {
      case .success(let success):
        result(.success(success))
      case .failure(let error):
        result(.failure(error))
      }
    }
  }
  
  func removeFavoriteGame(game: Game, result: @escaping (Result<Bool, Error>) -> Void) {
    locale.deleteFavorites(game.id ?? 0) { response in
      switch response {
      case .success(let success):
        result(.success(success))
      case .failure(let error):
        result(.failure(error))
      }
    }
  }
  
  func checkFavorites(id: Int, result: @escaping (Result<Game, Error>) -> Void) {
    locale.getGames(by: id) { response in
      switch response {
      case .success(let game):
        result(.success(game))
      case .failure(let error):
        result(.failure(error))
      }
    }
  }
  
  func deleteAll() {
    locale.deleteAll()
  }
  
  func getFavorites(result: @escaping (Result<[Game], Error>) -> Void) {
    locale.getAllFavorites { games in
      switch games {
      case .success(let success):
        result(.success(success))
      case .failure(let failure):
        result(.failure(failure))
      }
    }
  }
}
