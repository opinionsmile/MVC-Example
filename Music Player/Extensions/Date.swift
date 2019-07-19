//
//  Date.swift
//  Music Player
//
//  Created by John Lombardi on 7/19/19.
//

import Foundation

extension Date {

  /// Convert `String` to `Date` in `yyyy-MM-dd'T'HH:mm:ss'Z'` format
  static func getISODateWithString(_ stringDate: String) -> Date? {
    let isoFormatter = DateFormatter()
    isoFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    isoFormatter.locale = Locale(identifier: "en_US_POSIX")
    return isoFormatter.date(from: stringDate)
  }

  /// Get year from `Date`
  func getStringyyyyFormat() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy"
    return dateFormatter.string(from: self)
  }

  /// Convert `Date` to `String` in `MMM dd, yyyy` format
  func getStringMMMddyyyyFormat() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM dd, yyyy"
    return dateFormatter.string(from: self)
  }
  
}
