//
//  ContentView.swift
//  HelloCoreData
//
//  Created by Frederick Javalera on 11/20/21.
//

import SwiftUI

struct ContentView: View {
  let storageProvider: StorageProvider
  
  var body: some View {
    Text("Hello, world!")
      .padding()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(storageProvider: StorageProvider())
      .previewLayout(.sizeThatFits)
  }
}
