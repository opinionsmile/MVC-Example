//
//  AlbumManager.swift
//  Music Player
//
//  Created by John Lombardi on 7/20/19.
//

import Foundation

class AlbumManager {

  static let shared = AlbumManager()

  func getExtraLargeUrlWith(_ originalUrl: URL?) -> URL? {
    guard let originalUrl = originalUrl else {
      return nil
    }

    let urlString = originalUrl.absoluteString.replacingFirstOccurrence(of: "100x100", with: "200x200")
    return URL(string: urlString)
  }

}
