//
//  AlbumTests.swift
//  MusicPlayerTests
//
//  Created by John Lombardi on 7/21/19.
//

import XCTest
@testable import MusicPlayer

class AlbumTests: XCTestCase {

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
  }

  func testFetchAlbums() {
    var albums: [Album]? = nil
    if let path = Bundle(for: AlbumTests.self).url(forResource: "AlbumsTest", withExtension: "json") {
      do {
        let data = try Data(contentsOf: path, options: .mappedIfSafe)
        let processedData = try JSONDecoder().decode(AlbumsResponse.self, from: data)
        albums = Album.getAlbumsWith(processedData)
      } catch {
        print(error.localizedDescription)
      }
    }

    XCTAssert(albums != nil)
  }
  
}
