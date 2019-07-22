//
//  TrackManagerTests.swift
//  MusicPlayerTests
//
//  Created by John Lombardi on 7/21/19.
//

import XCTest
@testable import MusicPlayer

class TrackManagerTests: XCTestCase {

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
  }

  func testTrackTimemmssFormat() {
    let trackTimemmssFormat = TrackManager.shared.getTrackTimemmssFormatWith(trackTimeMillis: 243027)
    XCTAssert(trackTimemmssFormat == "4:03")
  }

}
