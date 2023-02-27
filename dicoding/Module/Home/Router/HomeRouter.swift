//
//  HomeRouter.swift
//  dicoding
//
//  Created by Mochammad Arief Ridwan on 20/02/23.
//

import Foundation
import UIKit
class HomeRouter {

  func makeDetailView(for game: Game, navigationController: UINavigationController) {
    let viewController = DetailViewController()
    let detailUseCase = Injection.init().provideDetail(game: game)
    let presenter = DetailPresenter(detailUseCase: detailUseCase)
    presenter.game = game
    viewController.presenter = presenter
    navigationController.pushViewController(viewController, animated: true)
  }
  
}
