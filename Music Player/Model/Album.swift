//
//  Album.swift
//  Music Player
//
//  Created by John Lombardi on 7/20/19.
//

import Foundation

struct Album {

  let albumId: Int
  let albumName: String
  let artistName: String
  let artworkUrl: URL?
  let tracks: [Track]

  init(albumId: Int, albumName: String, artistName: String, artworkUrl: URL?, tracks: [Track]) {
    self.albumId = albumId
    self.albumName = albumName
    self.artistName = artistName
    self.artworkUrl = artworkUrl
    self.tracks = tracks
  }

}

extension Album {

  /**
   * Get the view models (array) from the tracks response array
   *
   * - parameters:
   *      -trackResponse: the tracks response array
   */
  static func getAlbumsWith(_ albumsResponse: [AlbumResponse]) -> [Album] {
    return albumsResponse.map { getAlbumWith($0) }
  }

  /**
   * Get the view model (single view model) from the track response
   *
   * - parameters:
   *      -trackResponse: the track response
   */
  private static func getAlbumWith(_ albumResponse: AlbumResponse) -> Album {

    let artworkUrl = AlbumManager.shared.getExtraLargeUrlWith(URL(string: albumResponse.artworkUrl))
    let tracks = Track.getTracksWith(albumResponse.tracks)
    return Album(
      albumId: albumResponse.albumId,
      albumName: albumResponse.albumName,
      artistName: albumResponse.artistName,
      artworkUrl: artworkUrl,
      tracks: tracks
    )
  }

}

struct AlbumsResponse: Decodable {

  let resultCount: UInt
  let results: [AlbumsResponse]

}

struct AlbumResponse: Decodable {

  let albumId: Int
  let albumName: String
  let artistName: String
  let artworkUrl: String
  let tracks: [TrackResponse]

}
