//
//  Track.swift
//  Music Player
//
//  Created by John Lombardi on 7/19/19.
//

import Foundation

struct Track {
  let trackId: Int
  let trackName: String
  let releaseDate: String
  let releaseYear: String
  let previewUrl: URL?
  let primaryGenreName: String
  let trackViewUrl: URL?
  let trackDuration: String
  let trackPrice: String?
}

extension Track {

  /**
   * Get the view models (array) from the tracks response array
   *
   * - parameters:
   *      -trackResponse: the tracks response array
   */
  static func getTracksWith(_ tracksResponse: [TrackResponse]) -> [Track] {
    return tracksResponse.map { getTrackWith($0) }
  }

  /**
   * Get the view model (single view model) from the track response
   *
   * - parameters:
   *      -trackResponse: the track response
   */
  private static func getTrackWith(_ trackResponse: TrackResponse) -> Track {
    var releaseYear = ""
    var date = ""
    if let releaseDate = Date.getISODateWithString(trackResponse.releaseDate) {
      releaseYear = releaseDate.getStringyyyyFormat()
      date = releaseDate.getStringMMMddyyyyFormat()
    }

    var previewUrl: URL?
    if let url = trackResponse.previewUrl {
      previewUrl = URL(string: url)
    }

    let trackViewUrl = URL(string: trackResponse.trackViewUrl)

    let trackDuration = TrackManager.shared.getTrackTimemmssFormatWith(trackTimeMillis: trackResponse.trackTimeMillis)

    var trackPrice: String?
    if let price = trackResponse.trackPrice, price > 0.0 {
      trackPrice = "\(price) \(trackResponse.currency)"
    }

    return Track(
      trackId: trackResponse.trackId,
      trackName: trackResponse.trackName,
      releaseDate: date,
      releaseYear: releaseYear,
      previewUrl: previewUrl,
      primaryGenreName: trackResponse.primaryGenreName,
      trackViewUrl: trackViewUrl,
      trackDuration: trackDuration,
      trackPrice: trackPrice
    )
  }

}

struct TrackResponse: Decodable {

  let trackId: Int
  let trackName: String
  let trackViewUrl: String
  let previewUrl: String?
  let releaseDate: String
  let primaryGenreName: String
  let trackPrice: Float?
  let currency: String
  let trackTimeMillis: Int?

}
