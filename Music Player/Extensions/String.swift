//
//  String.swift
//  Music Player
//
//  John Lombardi on 7/19/19.
//

import Foundation

extension String {

  // Replace a substring
  func replacingFirstOccurrence(of string: String, with replacement: String) -> String {
    guard let range = self.range(of: string) else { return self }
    return replacingCharacters(in: range, with: replacement)
  }
  
}
