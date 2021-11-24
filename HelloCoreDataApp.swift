//
//  HelloCoreDataApp.swift
//  HelloCoreData
//
//  Created by Frederick Javalera on 11/20/21.
//

import SwiftUI

@main
struct HelloCoreDataApp: App {
  
  var body: some Scene {
    WindowGroup {
      ContentView(viewModel: ContentViewModel())
    }
  }
}
