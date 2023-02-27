//
//  HomeInteractor.swift
//  dicoding
//
//  Created by Mochammad Arief Ridwan on 20/02/23.
//

import Foundation

protocol HomeUseCase {

  func getGames(completion: @escaping (Result<[Game], Error>) -> Void)
  func getFavorites(completion: @escaping (Result<[Game], Error>) -> Void)

}

class HomeInteractor: HomeUseCase {

  private let repository: GameRepositoryProtocol
  
  required init(repository: GameRepositoryProtocol) {
    self.repository = repository
  }
  
  func getGames(
    completion: @escaping (Result<[Game], Error>) -> Void
  ) {
    repository.getGames { result in
      completion(result)
    }
  }

  func getFavorites(completion: @escaping (Result<[Game], Error>) -> Void) {
    repository.getFavorites { result in
      completion(result)
    }
  }
}
