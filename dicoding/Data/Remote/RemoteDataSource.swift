//
//  RemoteDataSource.swift
//  dicoding
//
//  Created by Mochammad Arief Ridwan on 18/02/23.
//

import Foundation
import Alamofire
import RxSwift


protocol RemoteDataSourceProtocol: AnyObject {
  
  func getGames() -> Observable<[Game]>
  func getDetailGame(game: Game) -> Observable<DetailGame>
  
}

final class RemoteDataSource: NSObject {
  
  private override init() { }
  
  static let sharedInstance: RemoteDataSource =  RemoteDataSource()
  
}

extension RemoteDataSource: RemoteDataSourceProtocol {
  
  func getGames() -> Observable<[Game]> {
    let params: [String: String] = [
      "key": Constants.APIKey,
      "page": "1",
      "page_size": "15"
    ]
    return Observable<[Game]>.create { observer in
      if let url = URL(string: Endpoint.listGame) {
        AF.request(url, parameters: params).validate().responseDecodable(of: ListGame.self) { response in
          switch response.result {
          case .success(let value):
            observer.onNext(value.results ?? [Game]())
            observer.onCompleted()
          case .failure:
            observer.onError(URLError.invalidResponse)
          }
        }
      }
      return Disposables.create()
    }
  }
  
  func getDetailGame(game: Game) -> Observable<DetailGame> {
    let params: [String: String] = [
      "key": Constants.APIKey,
      "page": "1",
      "page_size": "15"
    ]
    return Observable<DetailGame>.create { observer in
      if let url = URL(string: "\(Endpoint.listGame)/\(game.id ?? 0)") {
        AF.request(url, parameters: params).validate().responseDecodable(of: DetailGame.self) { response in
          switch response.result {
          case .success(let value):
            observer.onNext(value)
            observer.onCompleted()
          case .failure:
            observer.onError(URLError.invalidResponse)
          }
        }
      }
      return Disposables.create()
    }
  }
}
