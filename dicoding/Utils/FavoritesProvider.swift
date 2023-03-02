//
//  GamesProvider.swift
//  dicoding
//
//  Created by Mochammad Arief Ridwan on 07/02/23.
//

import CoreData
import UIKit
import RxSwift

class FavoritesProvider {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Favorites")
        
        container.loadPersistentStores { _, error in
            guard error == nil else {
                fatalError("Unresolved error \(error!)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = false
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.shouldDeleteInaccessibleFaults = true
        container.viewContext.undoManager = nil
        
        return container
    }()
  
  private func newTaskContext() -> NSManagedObjectContext {
          let taskContext = persistentContainer.newBackgroundContext()
          taskContext.undoManager = nil
          
          taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
          return taskContext
      }
  
  func getAllFavorites() -> Observable<[Game]> {
    return Observable<[Game]>.create { observer in
      let taskContext = self.newTaskContext()
      taskContext.perform {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorites")
        do {
          let results = try taskContext.fetch(fetchRequest)
          var games: [Game] = []
          for result in results {
            let game = Game(
              id: result.value(forKeyPath: "id") as? Int ?? 0,
              name: result.value(forKeyPath: "name") as? String ?? "",
              releasedDate: result.value(forKeyPath: "released_date") as? String ?? "",
              rating: result.value(forKeyPath: "rating") as? Double ?? 0,
              added: result.value(forKeyPath: "added") as? Int ?? 0,
              esrbRating: result.value(forKeyPath: "esrb_rating") as? String ?? "",
              descriptionRaw: result.value(forKeyPath: "description_raw") as? String ?? "",
              savedImage: result.value(forKeyPath: "image") as? Data ?? Data())
            games.append(game)
          }
          observer.onNext(games)
          observer.onCompleted()
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
          observer.onError(error)
        }
      }
      return Disposables.create()
    }
  }
  
  func getGame(by id: Int) -> Observable<Game> {
    return Observable<Game>.create { observer in
      let taskContext = self.newTaskContext()
      taskContext.perform {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorites")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "id == \(id)")
        do {
          if let result = try taskContext.fetch(fetchRequest).first {
            let game = Game(
              id: result.value(forKeyPath: "id") as? Int ?? 0,
              name: result.value(forKeyPath: "name") as? String ?? "",
              releasedDate: result.value(forKeyPath: "released_date") as? String ?? "",
              rating: result.value(forKeyPath: "rating") as? Double ?? 0,
              added: result.value(forKeyPath: "added") as? Int ?? 0,
              esrbRating: result.value(forKeyPath: "esrb_rating") as? String ?? "",
              descriptionRaw: result.value(forKeyPath: "description_raw") as? String ?? "",
              savedImage: result.value(forKeyPath: "image") as? Data ?? Data()
            )
            observer.onNext(game)
            observer.onCompleted()
          }
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
          observer.onError(error)
        }
      }
      return Disposables.create()
    }
  }
  
  func createFavorites(id: Int, name: String, releasedDate: String, rating: Double, added: Int, esrbRating: String, descriptionRaw: String, image: Data) -> Observable<Bool> {
    return Observable<Bool>.create { observer in
      let taskContext = self.newTaskContext()
      taskContext.performAndWait {
        if let entity = NSEntityDescription.entity(forEntityName: "Favorites", in: taskContext) {
          let game = NSManagedObject(entity: entity, insertInto: taskContext)
          game.setValue(id, forKeyPath: "id")
          game.setValue(name, forKeyPath: "name")
          game.setValue(releasedDate, forKeyPath: "released_date")
          game.setValue(rating, forKeyPath: "rating")
          game.setValue(added, forKeyPath: "added")
          game.setValue(esrbRating, forKeyPath: "esrb_rating")
          game.setValue(descriptionRaw, forKeyPath: "description_raw")
          game.setValue(image, forKey: "image")
          do {
            try taskContext.save()
            observer.onNext(true)
            observer.onCompleted()
          } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            observer.onError(error)
          }
        }
      }
      return Disposables.create()
    }
  }
  
  func deleteFavorites(_ id: Int) -> Observable<Bool> {
    return Observable<Bool>.create { observer in
      let taskContext = self.newTaskContext()
      taskContext.perform {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorites")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "id == \(id)")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        batchDeleteRequest.resultType = .resultTypeCount
        if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult {
          if batchDeleteResult.result != nil {
            observer.onNext(true)
          }
        }
      }
      return Disposables.create()
    }
  }
  
  func deleteAll() {
    let context = persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorites")
    let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
    do {
        try context.execute(batchDeleteRequest)
    } catch {
    }
  }
}
