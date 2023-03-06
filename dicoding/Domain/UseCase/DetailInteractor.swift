//
//  DetailInteractor.swift
//  dicoding
//
//  Created by Mochammad Arief Ridwan on 20/02/23.
//

import Foundation
import UIKit
import RxSwift

protocol DetailUseCase {

  func getDetailGame(game: Game) -> Observable<DetailGame>
  func setFavorites(game: Game, image: Data) -> Observable<Bool>
  func removeFavorites(game: Game) -> Observable<Bool>
  func checkFavorites(id: Int) -> Observable<Game>
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

  func getDetailGame(game: Game) -> Observable<DetailGame> {
    repository.getDetailGame(game: game)
  }
  
  func setFavorites(game: Game, image: Data) -> Observable<Bool> {
    repository.addFavoriteGame(game: game, image: image)
  }
  
  func removeFavorites(game: Game) -> Observable<Bool> {
    repository.removeFavoriteGame(game: game)
  }

  func checkFavorites(id: Int) -> Observable<Game> {
    repository.checkFavorites(id: id)
  }
  
  func deleteAll() {
    repository.deleteAll()
  }
}
