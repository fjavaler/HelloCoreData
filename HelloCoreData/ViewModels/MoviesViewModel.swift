//
//  MoviesViewModel.swift
//  HelloCoreData
//
//  Created by Frederick Javalera on 11/20/21.
//

import Foundation
import CoreData
import SwiftUI

class MoviesViewModel: ObservableObject {
  @Published var searchText: SearchText = SearchText()
  @Published var movies: [String] = []
  @Published var isSortedAscending = false
  let storageProvider: StorageProvider
  
  init(storageProvider: StorageProvider) {
    self.storageProvider = storageProvider
  }
  
  static var moviesByRating: NSFetchRequest<Movie> = {
    let request: NSFetchRequest<Movie> = Movie.fetchRequest()
    request.sortDescriptors = [NSSortDescriptor(keyPath: \Movie.rating, ascending: false)]
    
    return request
  }()
  
  static var moviesByReleaseDate: NSFetchRequest<Movie> = {
    let request: NSFetchRequest<Movie> = Movie.fetchRequest()
    request.sortDescriptors = [NSSortDescriptor(keyPath: \Movie.releaseDate, ascending: false)]
    
    return request
  }()
}
