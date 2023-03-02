//
//  HomePresenter.swift
//  dicoding
//
//  Created by Mochammad Arief Ridwan on 20/02/23.
//

import Foundation
import UIKit
import RxSwift

class HomePresenter: ObservableObject {
  private let router = HomeRouter()
  private let homeUseCase: HomeUseCase
  private let disposeBag = DisposeBag()
  
  @Published var games: [Game] = []
  @Published var errorMessage: String = ""
  @Published var loadingState: Bool = false
  
  init(homeUseCase: HomeUseCase) {
    self.homeUseCase = homeUseCase
  }
  
  func getGames(completion: @escaping () -> Void) {
    loadingState = true
    homeUseCase.getGames()
      .observe(on: MainScheduler.instance)
      .subscribe { result in
        self.games = result
      } onError: { error in
        self.errorMessage = error.localizedDescription
      } onCompleted: {
        self.loadingState = false
        completion()
      }.disposed(by: disposeBag)
    
//    { result in
//      switch result {
//      case .success(let games):
//        DispatchQueue.main.async {
//          self.loadingState = false
//          self.games = games
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
 
  func goToDetail(with game: Game, navigationController: UINavigationController) {
    self.router.makeDetailView(for: game, navigationController: navigationController)
  }
  
  func getAllFavorites(completion: @escaping () -> Void) {
    loadingState = true
    homeUseCase.getFavorites()
      .observe(on: MainScheduler.instance)
      .subscribe { result in
        self.games = result
      } onError: { error in
        self.errorMessage = error.localizedDescription
      } onCompleted: {
        self.loadingState = false
        completion()
      }.disposed(by: disposeBag)

//    { result in
//      switch result {
//      case .success(let games):
//        DispatchQueue.main.async {
//          self.loadingState = false
//          self.games = games
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
}
