//
//  TrackManager.swift
//  Music Player
//
//  Created by John Lombardi on 7/19/19.
//

import Foundation

class TrackManager {
  
  static let shared: TrackManager = { return TrackManager() }()
  
  func getExtraLargeUrlWith(_ originalUrl: URL?) -> URL? {
    guard let originalUrl = originalUrl else {
      return nil
    }
    
    let urlString = originalUrl.absoluteString.replacingFirstOccurrence(of: "100x100", with: "200x200")
    return URL(string: urlString)
  }
  
  func getTrackTimemmssFormatWith(trackTimeMillis: Int?) -> String {
    guard let trackTimeMillis = trackTimeMillis else {
      return ""
    }
    return trackTimeMillis.msToSeconds.minuteSecond
  }
  
}
