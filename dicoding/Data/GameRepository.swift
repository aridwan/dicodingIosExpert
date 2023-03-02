//
//  GameRepository.swift
//  dicoding
//
//  Created by Mochammad Arief Ridwan on 18/02/23.
//

import Foundation
import UIKit
import RxSwift

protocol GameRepositoryProtocol {
  
  func getGames() -> Observable<[Game]>
  func getDetailGame(game: Game) -> Observable<DetailGame>
  func addFavoriteGame(game: Game, image: Data) -> Observable<Bool>
  func removeFavoriteGame(game: Game) -> Observable<Bool>
  func checkFavorites(id: Int) -> Observable<Game>
  func deleteAll()
  func getFavorites() -> Observable<[Game]>
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
  func getGames() -> Observable<[Game]> {
    return remote.getGames()
//    remote.getGames { response in
//      switch response {
//      case (.success(let gameResponses)):
//        result(.success(gameResponses))
//      case .failure(let error):
//        result(.failure(error))
//      }
      
//    }
  }

  func getDetailGame(game: Game) -> Observable<DetailGame> {
    remote.getDetailGame(game: game)
//    remote.getDetailGame(game: game) { response in
//      switch response {
//      case (.success(let gameResponse)):
//        result(.success(gameResponse))
//      case .failure(let error):
//        result(.failure(error))
//      }
//
//    }
  }

  func addFavoriteGame(game: Game, image: Data) -> Observable<Bool> {
    locale.createFavorites(id: game.id ?? 0,
                           name: game.name ?? "",
                           releasedDate: game.released ?? "",
                           rating: game.rating ?? 0,
                           added: game.added ?? 0,
                           esrbRating: game.esrbRating?.name?.rawValue ?? "",
                           descriptionRaw: game.descriptionRaw ?? "",
                           image: image)
//    { response in
//      switch response {
//      case .success(let success):
//        result(.success(success))
//      case .failure(let error):
//        result(.failure(error))
//      }
//    }
  }
  
  func removeFavoriteGame(game: Game) -> Observable<Bool> {
     locale.deleteFavorites(game.id ?? 0)
//      switch response {
//      case .success(let success):
//        result(.success(success))
//      case .failure(let error):
//        result(.failure(error))
//      }
//    }
  }
  
  func checkFavorites(id: Int) -> Observable<Game> {
    locale.getGame(by: id)
//    { response in
//      switch response {
//      case .success(let game):
//        result(.success(game))
//      case .failure(let error):
//        result(.failure(error))
//      }
//    }
  }
  
  func deleteAll() {
    locale.deleteAll()
  }
  
  func getFavorites() -> Observable<[Game]> {
    locale.getAllFavorites()
//    { games in
//      switch games {
//      case .success(let success):
//        result(.success(success))
//      case .failure(let failure):
//        result(.failure(failure))
//      }
//    }
  }
}
