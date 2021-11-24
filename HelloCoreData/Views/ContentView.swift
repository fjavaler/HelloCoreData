//
//  ContentView.swift
//  HelloCoreData
//
//  Created by Frederick Javalera on 11/20/21.
//

import SwiftUI

struct ContentView: View {
  @StateObject var viewModel: ContentViewModel
  var body: some View {
    
    ZStack {
      
      LinearGradient(colors: [Color.blue, Color.purple], startPoint: .topLeading, endPoint: .bottomTrailing)
        .ignoresSafeArea()
      
      VStack {
        
        TextField("Movie name", text: $viewModel.movieName)
          .padding()
          .background(RoundedRectangle(cornerRadius: 10).stroke())
          .padding(.vertical, 75)
          .padding(.top, 75)
        
        
        Button {
          viewModel.onSubmitButtonPressed()
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
        
        List {
          let movies = viewModel.storageProvider.getAllMovies()
          ForEach(movies) {movie in
            Text(movie.title ?? "")
              .listRowBackground(LinearGradient(colors: [.purple, .blue], startPoint: .leading, endPoint: .trailing))
              .swipeActions(content: {
                Button("Delete") {
                  do {
                    try viewModel.storageProvider.deleteMovie(movie)
                  } catch {
                    print("Error deleting movie: \(error)")
                  }
                  print("Movie deleted!")
                }
                .tint(.red)
              })
          }
        }
        .listStyle(.automatic)
        .onAppear {
          UITableView.appearance().backgroundColor = UIColor.clear
        }
        
        Spacer()
      }
      .padding(.horizontal, 100)
    }
    
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(viewModel: ContentViewModel())
      .previewLayout(.sizeThatFits)
  }
}
