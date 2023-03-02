//
//  DetailPresenter.swift
//  dicoding
//
//  Created by Mochammad Arief Ridwan on 20/02/23.
//

import Foundation
import UIKit
import RxSwift

class DetailPresenter: ObservableObject {
  private let detailUseCase: DetailUseCase
  private let disposeBag = DisposeBag()
 
  @Published var detailGame: DetailGame?
  @Published var game: Game?
  @Published var errorMessage: String = ""
  @Published var loadingState: Bool = false
  
  init(detailUseCase: DetailUseCase) {
    self.detailUseCase = detailUseCase
  }
  
  func getDetailGame(game: Game, completion: @escaping () -> Void) {
    loadingState = true
    detailUseCase.getDetailGame(game: game)
      .observe(on: MainScheduler.instance)
      .subscribe { result in
        self.detailGame = result
      } onError: { error in
        self.errorMessage = error.localizedDescription
      } onCompleted: {
        self.loadingState = false
        completion()
      }.disposed(by: disposeBag)
    
//    { result in
//      switch result {
//      case .success(let detailGame):
//        DispatchQueue.main.async {
//          self.loadingState = false
//          self.detailGame = detailGame
//          completion()
//        }
//      case .failure(let error):
//        DispatchQueue.main.async {
//          self.loadingState = false
//          self.errorMessage = error.localizedDescription
//          completion()
//        }
//      }
//    }
  }
  
  func setFavorites(game: Game, image: Data, completion: @escaping (Bool) -> Void) {
    detailUseCase.setFavorites(game: game, image: image)
      .observe(on: MainScheduler.instance)
      .subscribe {_ in
        completion(true)
      } onError: { error in
        self.errorMessage = error.localizedDescription
      } onCompleted: {
        self.loadingState = false
        completion(false)
      }.disposed(by: disposeBag)
    
//    { result in
//      switch result {
//      case .success:
//          completion(true)
//      case .failure(let error):
//        self.loadingState = false
//        self.errorMessage = error.localizedDescription
//        completion(false)
//      }
//    }
  }
  
  func removeFavorites(game: Game, completion: @escaping (Bool) -> Void) {
    detailUseCase.removeFavorites(game: game)
      .observe(on: MainScheduler.instance)
      .subscribe { _ in
        completion(true)
      } onError: { error in
        self.errorMessage = error.localizedDescription
      } onCompleted: {
        self.loadingState = false
        completion(false)
      } .disposed(by: disposeBag)
    
//    { result in
//      switch result {
//      case .success:
//          completion(true)
//      case .failure(let error):
//        self.loadingState = false
//        self.errorMessage = error.localizedDescription
//        completion(false)
//      }
//    }
  }
  
  func checkFavorites(id: Int, completion: @escaping (Game?) -> Void) {
    detailUseCase.checkFavorites(id: id)
      .observe(on: MainScheduler.instance)
      .subscribe { result in
        completion(result)
      } onError: { error in
        self.errorMessage = error.localizedDescription
      } onCompleted: {
      }.disposed(by: disposeBag)
//    { result in
//      switch result {
//      case .success(let game):
//        completion(game)
//      case .failure:
//        break
//      }
//    }
  }
  
  func deleteAll() {
    detailUseCase.deleteAll()
  }
}
