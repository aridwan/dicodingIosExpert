//
//  GamesProvider.swift
//  dicoding
//
//  Created by Mochammad Arief Ridwan on 07/02/23.
//

import CoreData
import UIKit

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
  
  func getAllFavorites(completion: @escaping(_ favorites: [Result]) -> Void) {
    let taskContext = newTaskContext()
    taskContext.perform {
      let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorites")
      do {
        let results = try taskContext.fetch(fetchRequest)
        var games: [Result] = []
        for result in results {
          let game = Result(
            id: result.value(forKeyPath: "id") as? Int ?? 0,
            name: result.value(forKeyPath: "name") as? String ?? "",
            released_date: result.value(forKeyPath: "released_date") as? String ?? "",
            rating: result.value(forKeyPath: "rating") as? Double ?? 0,
            added: result.value(forKeyPath: "added") as? Int ?? 0,
            esrbRating: result.value(forKeyPath: "esrb_rating") as? String ?? "",
            description_raw: result.value(forKeyPath: "description_raw") as? String ?? "",
            savedImage: result.value(forKeyPath: "image") as? Data ?? Data())
          games.append(game)
        }
        completion(games)
      } catch let error as NSError{
        print("Could not fetch. \(error), \(error.userInfo)")
      }
    }
  }
  
  func getGames(by id: Int, completion: @escaping(_ game: Result) -> Void){
    let taskContext = newTaskContext()
        taskContext.perform {
          let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorites")
          fetchRequest.fetchLimit = 1
          fetchRequest.predicate = NSPredicate(format: "id == \(id)")
          do {
            if let result = try taskContext.fetch(fetchRequest).first {
              let game = Result(
                id: result.value(forKeyPath: "id") as? Int ?? 0,
                name: result.value(forKeyPath: "name") as? String ?? "",
                released_date: result.value(forKeyPath: "released_date") as? String ?? "",
                rating: result.value(forKeyPath: "rating") as? Double ?? 0,
                added: result.value(forKeyPath: "added") as? Int ?? 0,
                esrbRating: result.value(forKeyPath: "esrb_rating") as? String ?? "",
                description_raw: result.value(forKeyPath: "description_raw") as? String ?? "",
                savedImage: result.value(forKeyPath: "image") as? Data ?? Data()
              )
              completion(game)
            }
          } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
          }
        }
  }
  
  func createFavorites(id: Int, name: String, released_date: String, rating: Double, added: Int, esrb_rating: String, description_raw: String, image: Data) {
      let taskContext = newTaskContext()
      taskContext.performAndWait {
        if let entity = NSEntityDescription.entity(forEntityName: "Favorites", in: taskContext) {
          let game = NSManagedObject(entity: entity, insertInto: taskContext)
            game.setValue(id, forKeyPath: "id")
            game.setValue(name, forKeyPath: "name")
            game.setValue(released_date, forKeyPath: "released_date")
            game.setValue(rating, forKeyPath: "rating")
            game.setValue(added, forKeyPath: "added")
            game.setValue(esrb_rating, forKeyPath: "esrb_rating")
            game.setValue(description_raw, forKeyPath: "description_raw")
            game.setValue(image, forKey: "image")
            do {
              try taskContext.save()
            } catch let error as NSError {
              print("Could not save. \(error), \(error.userInfo)")
            }
        }
      }
    }
  
  func getMaxId(completion: @escaping(_ maxId: Int) -> Void) {
    let taskContext = newTaskContext()
    taskContext.performAndWait {
      let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorites")
      let sortDescriptor = NSSortDescriptor(key: "id", ascending: false)
      fetchRequest.sortDescriptors = [sortDescriptor]
      fetchRequest.fetchLimit = 1
      do {
        let lastMember = try taskContext.fetch(fetchRequest)
        if let member = lastMember.first, let position = member.value(forKeyPath: "id") as? Int {
          completion(position)
        } else {
          completion(0)
        }
      } catch {
        print(error.localizedDescription)
      }
    }
  }

  func deleteFavorites(_ id: Int) {
      let taskContext = newTaskContext()
      taskContext.perform {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorites")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "id == \(id)")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        batchDeleteRequest.resultType = .resultTypeCount
        if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult {
          if batchDeleteResult.result != nil {
            
          }
        }
      }
    }
  
}
