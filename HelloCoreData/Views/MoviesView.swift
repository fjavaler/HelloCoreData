//
//  MoviesView.swift
//  HelloCoreData
//
//  Created by Frederick Javalera on 11/20/21.
//

import SwiftUI

struct MoviesView: View {
  @StateObject var viewModel: MoviesViewModel
  @EnvironmentObject var storageProvider: StorageProvider
  @FetchRequest(fetchRequest: MoviesViewModel.moviesByReleaseDate)
  var movies: FetchedResults<Movie>
  
  var body: some View {
    
    ZStack {
      
      LinearGradient(colors: [Color.blue, Color.purple], startPoint: .topLeading, endPoint: .bottomTrailing)
        .ignoresSafeArea()
      
      VStack {
        
        Button {
          viewModel.isSortedAscending.toggle()
        } label: {
          Text(viewModel.isSortedAscending ? "Switch to descending order" : "Switch to ascending order")
        }
        
        TextField("Movie name", text: $viewModel.searchText.text)
          .padding()
          .background(RoundedRectangle(cornerRadius: 10).stroke())
          .padding(.vertical, 75)
          .padding(.top, 75)
        
        Button {
          storageProvider.saveMovie(named: viewModel.searchText.text)
        } label: {
          Text("Submit")
            .foregroundColor(Color.white)
        }
        .background(
          Capsule(style: RoundedCornerStyle.circular)
            .stroke()
            .fill()
            .frame(width: 100, height: 50)
        )
        .padding(.bottom, 75)
        
        List(movies) { movie in
          Text(movie.title ?? "")
            .listRowBackground(LinearGradient(colors: [.purple, .blue], startPoint: .leading, endPoint: .trailing))
            .swipeActions(content: {
              Button("Delete") {
                do {
                  try storageProvider.deleteMovie(movie)
                } catch {
                  print("Error deleting movie: \(error)")
                }
                print("Movie deleted!")
              }
              .tint(.red)
            })
        }
        .listStyle(.automatic)
        .onAppear {
          UITableView.appearance().backgroundColor = UIColor.clear
        }
        
        Spacer()
      }
      .padding(.horizontal, 100)
      .onReceive(viewModel.searchText.$debounced) { query in
        guard !query.isEmpty else {
          movies.nsPredicate = nil
          return
        }
        
        movies.nsPredicate = NSPredicate(format: "%K CONTAINS[cd] %@", argumentArray: [#keyPath(Movie.title), query])
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    MoviesView(viewModel: MoviesViewModel(storageProvider: StorageProvider()))
      .previewLayout(.sizeThatFits)
  }
}
