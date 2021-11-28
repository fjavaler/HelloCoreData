//
//  StorageProvider.swift
//  HelloCoreData
//
//  Created by Frederick Javalera on 11/20/21.
//

import CoreData

enum DataErrors: Error {
  case deleteError(movie: Movie)
}

class StorageProvider {
  
  // MARK: Properties
  let persistentContainer: NSPersistentContainer
  
  // MARK: Init
  init() {
    
    // Sets a value transformer for use (e.g. UIImageTransformer transforms an image to data and vice-versa).
    ValueTransformer.setValueTransformer(UIImageTransformer(), forName: NSValueTransformerName(rawValue: "UIImageTransformer"))
    
    persistentContainer = NSPersistentContainer(name: "HelloCoreData")
    
    persistentContainer.loadPersistentStores { description, error in
      if let error = error {
        fatalError("Core Data store failed to load with error: \(error).")
      }
    }
  }
  
  // MARK: Methods
  func saveMovie(named name: String) {
    let movie = Movie(context: persistentContainer.viewContext)
    movie.title = name
    
    do {
      try persistentContainer.viewContext.save()
      print("Movie saved successfully")
    } catch {
      persistentContainer.viewContext.rollback()
      print("Failed to save movie: \(error)")
    }
  }
  
  func getAllMovies() -> [Movie] {
    let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
    
    do {
      return try persistentContainer.viewContext.fetch(fetchRequest)
    } catch {
      print("Failed to fetch movies: \(error)")
      return []
    }
  }
  
  func deleteMovie(_ movie: Movie) throws {
    persistentContainer.viewContext.delete(movie)
    
    do {
      try persistentContainer.viewContext.save()
    } catch {
      persistentContainer.viewContext.rollback()
      throw DataErrors.deleteError(movie: movie)
    }
  }
  
  func updateMovies() {
    do {
      try persistentContainer.viewContext.save()
    } catch {
      persistentContainer.viewContext.rollback()
      print("Failed to save context: \(error)")
    }
  }

  
}
