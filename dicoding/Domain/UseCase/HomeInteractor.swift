//
//  HomeInteractor.swift
//  dicoding
//
//  Created by Mochammad Arief Ridwan on 20/02/23.
//

import Foundation
import RxSwift

protocol HomeUseCase {

  func getGames() -> Observable<[Game]>
  func getFavorites() -> Observable<[Game]>

}

class HomeInteractor: HomeUseCase {

  private let repository: GameRepositoryProtocol
  
  required init(repository: GameRepositoryProtocol) {
    self.repository = repository
  }
  
  func getGames() -> Observable<[Game]> {
    repository.getGames()
  }

  func getFavorites() -> Observable<[Game]> {
    repository.getFavorites()
  }
}
