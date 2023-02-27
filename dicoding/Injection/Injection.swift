//
//  Injection.swift
//  dicoding
//
//  Created by Mochammad Arief Ridwan on 18/02/23.
//

import Foundation

final class Injection: NSObject {
 
  private func provideRepository() -> GameRepositoryProtocol {
    let remote: RemoteDataSource = RemoteDataSource.sharedInstance
    let locale: FavoritesProvider = FavoritesProvider()
    return GameRepository.sharedInstance(remote, locale)
  }
 
  func provideHome() -> HomeUseCase {
    let repository = provideRepository()
    return HomeInteractor(repository: repository)
  }
 
  func provideDetail(game: Game) -> DetailUseCase {
    let repository = provideRepository()
    return DetailInteractor(repository: repository, game: game)
  }

}
