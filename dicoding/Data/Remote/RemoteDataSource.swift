//
//  RemoteDataSource.swift
//  dicoding
//
//  Created by Mochammad Arief Ridwan on 18/02/23.
//

import Foundation
import Alamofire

protocol RemoteDataSourceProtocol: AnyObject {

  func getGames(result: @escaping (Result<[Game], URLError>) -> Void)
  func getDetailGame(game: Game, result: @escaping (Result<DetailGame, URLError>) -> Void)

}

final class RemoteDataSource: NSObject {

  private override init() { }

  static let sharedInstance: RemoteDataSource =  RemoteDataSource()

}

extension RemoteDataSource: RemoteDataSourceProtocol {

  func getGames(result: @escaping (Result<[Game], URLError>) -> Void) {
    guard let url = URL(string: Endpoint.listGame) else { return }

    let params: [String: String] = [
      "key": Constants.APIKey,
      "page": "1",
      "page_size": "15"
    ]
    
    AF.request(url, parameters: params).validate().responseDecodable(of: ListGame.self) { response in
      switch response.result {
      case .success(let value):
        result(.success(value.results ?? [Game]()))
      case .failure:
        result(.failure(.invalidResponse))
      }

    }
  }
  
  func getDetailGame(game: Game, result: @escaping (Result<DetailGame, URLError>) -> Void) {
    guard let url = URL(string: "\(Endpoint.listGame)/\(game.id ?? 0)") else { return }

    let params: [String: String] = [
      "key": Constants.APIKey,
      "page": "1",
      "page_size": "15"
    ]
    
    AF.request(url, parameters: params).validate().responseDecodable(of: DetailGame.self) { response in
      switch response.result {
      case .success(let value):
        result(.success(value))
      case .failure:
        result(.failure(.invalidResponse))
      }

    }
  }
}
