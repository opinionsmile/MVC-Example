//
//  TrackManager.swift
//  Music Player
//
//  Created by John Lombardi on 7/19/19.
//

import Foundation

class TrackManager {

  static let shared = TrackManager()

  func getTrackTimemmssFormatWith(trackTimeMillis: Int?) -> String {
    guard let trackTimeMillis = trackTimeMillis else {
      return ""
    }
    return trackTimeMillis.msToSeconds.minuteSecond
  }

}
