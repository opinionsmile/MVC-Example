//
//  Track.swift
//  Music Player
//
//  Created by John Lombardi on 7/19/19.
//

import Foundation

struct Track {

  let trackId: Int
  let artistName: String
  let trackName: String
  let artworkUrl: URL?
  let releaseDate: String
  let releaseYear: String
  let previewUrl: URL?
  let primaryGenreName: String
  let trackViewUrl: URL?
  let trackDuration: String
  let trackPrice: String?
  let albumName: String?

  init(trackId: Int, artistName: String, trackName: String, artworkUrl: URL?, releaseDate: String, releaseYear: String, previewUrl: URL?, primaryGenreName: String, trackViewUrl: URL?, trackDuration: String, trackPrice: String?, albumName: String?) {
    self.trackId = trackId
    self.artistName = artistName
    self.trackName = trackName
    self.artworkUrl = artworkUrl
    self.releaseDate = releaseDate
    self.releaseYear = releaseYear
    self.previewUrl = previewUrl
    self.primaryGenreName = primaryGenreName
    self.trackViewUrl = trackViewUrl
    self.trackDuration = trackDuration
    self.trackPrice = trackPrice
    self.albumName = albumName
  }

}

extension Track {

  /**
   * Get the view models (array) from the tracks response array
   *
   * - parameters:
   *      -trackResponse: the tracks response array
   */
  static func getViewModelsWith(_ trackResponse: [TrackResponse]) -> [Track] {
    return trackResponse.map { getViewModelWith($0) }
  }

  /**
   * Get the view model (single view model) from the track response
   *
   * - parameters:
   *      -trackResponse: the track response
   */
  private static func getViewModelWith(_ trackResponse: TrackResponse) -> Track {
    let artworkUrl = TrackManager.shared.getExtraLargeUrlWith(URL(string: trackResponse.artworkUrl))
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

    return Track(trackId: trackResponse.trackId, artistName: trackResponse.artistName, trackName: trackResponse.trackName, artworkUrl: artworkUrl, releaseDate: date, releaseYear: releaseYear, previewUrl: previewUrl, primaryGenreName: trackResponse.primaryGenreName, trackViewUrl: trackViewUrl, trackDuration: trackDuration, trackPrice: trackPrice, albumName: trackResponse.albumName)
  }

}

struct TracksResponse: Decodable {

  let resultCount: UInt
  let results: [TrackResponse]

}

struct TrackResponse: Decodable {

  let artistName: String
  let trackId: Int
  let trackName: String
  let trackViewUrl: String
  let previewUrl: String?
  let artworkUrl: String
  let releaseDate: String
  let primaryGenreName: String
  let trackPrice: Float?
  let currency: String
  let trackTimeMillis: Int?
  let albumName: String?

}
