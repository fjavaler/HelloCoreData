//
//  HelloCoreDataApp.swift
//  HelloCoreData
//
//  Created by Frederick Javalera on 11/20/21.
//

import SwiftUI

@main
struct HelloCoreDataApp: App {
  @StateObject var storageProvider: StorageProvider = StorageProvider()
  
  var body: some Scene {
    WindowGroup {
      MoviesView(viewModel: MoviesViewModel(storageProvider: storageProvider))
        .environment(\.managedObjectContext, storageProvider.persistentContainer.viewContext)
        .environmentObject(storageProvider)
    }
  }
}
