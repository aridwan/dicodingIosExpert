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
  }
  
  func deleteAll() {
    detailUseCase.deleteAll()
  }
}
