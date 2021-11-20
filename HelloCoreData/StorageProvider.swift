//
//  StorageProvider.swift
//  HelloCoreData
//
//  Created by Frederick Javalera on 11/20/21.
//

import CoreData

class StorageProvider {
  let persistentContainer: NSPersistentContainer
  
  init() {
    persistentContainer = NSPersistentContainer(name: "HelloCoreData")
    
    persistentContainer.loadPersistentStores { description, error in
      if let error = error {
        fatalError("Core Data store failed to load with error: \(error).")
      }
    }
  }
}
