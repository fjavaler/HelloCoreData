//
//  UIImageTransformer.swift
//  HelloCoreData
//
//  Created by Frederick Javalera on 11/28/21.
//

import Foundation
import UIKit

class UIImageTransformer: ValueTransformer {
  
  // Convert image to data.
  override func transformedValue(_ value: Any?) -> Any? {
    guard let image = value as? UIImage else {
      return nil
    }
    
    do {
      let data = try NSKeyedArchiver.archivedData(withRootObject: image, requiringSecureCoding: true)
      return data
    } catch {
      return nil
    }
  }
  
  // Convert data to image.
  override func reverseTransformedValue(_ value: Any?) -> Any? {
    guard let data = value as? Data else {
      return nil
    }
    
    do {
      let image = try NSKeyedUnarchiver.unarchivedObject(ofClass: UIImage.self, from: data)
      return image
    } catch {
      return nil
    }
  }
}
