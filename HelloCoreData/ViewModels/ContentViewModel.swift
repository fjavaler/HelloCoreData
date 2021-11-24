//
//  ContentViewModel.swift
//  HelloCoreData
//
//  Created by Frederick Javalera on 11/20/21.
//

import Foundation

class ContentViewModel: ObservableObject {
  @Published var movieName: String = ""
  @Published var movies: [String] = []
  let storageProvider: StorageProvider = StorageProvider()
  
  func onSubmitButtonPressed() {
    storageProvider.saveMovie(named: movieName)
  }
}
