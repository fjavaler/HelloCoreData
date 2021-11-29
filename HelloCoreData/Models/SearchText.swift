//
//  SearchText.swift
//  HelloCoreData
//
//  Created by Frederick Javalera on 11/28/21.
//

import Foundation

class SearchText: ObservableObject {
  @Published var text = ""
  @Published private(set) var debounced = ""
  
  init() {
    $text
      .debounce(for: 0.3, scheduler: DispatchQueue.main)
      .removeDuplicates()
      .assign(to: &$debounced)
  }
}
