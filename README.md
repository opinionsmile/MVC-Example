# MVC Example

## Architecture 
![alt tag](https://developer.apple.com/library/archive/documentation/General/Conceptual/DevPedia-CocoaCore/Art/model_view_controller_2x.png)

References:
* [MVC architecture](https://en.wikipedia.org/wiki/model-view-controller)
* [MVC for iOS](https://www.raywenderlich.com/1000705-model-view-controller-mvc-in-ios-a-modern-approach)

## First at all. Where is the data came from?

I'm loading the data from the local json file - `Albums.json`.

## Data models

```swift
struct Album {
  let albumId: Int
  let albumName: String
  let artistName: String
  let artworkUrl: URL?
  let tracks: [Track]
}

struct AlbumsResponse: Decodable {
  let resultCount: UInt
  let results: [AlbumResponse]
}

struct AlbumResponse: Decodable {
  let albumId: Int
  let albumName: String
  let artistName: String
  let artworkUrl: String
  let tracks: [TrackResponse]
}

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
```

I'm using a Swift Standard Library decodable functionality in order to manage a type that can decode itself from an external representation.

Reference: [Apple documentation](https://developer.apple.com/documentation/swift/swift_standard_library/encoding_decoding_and_serialization)

## Managers

### AlbumManager

Used to process the albums from the json data.

### TrackManager

Used to process the tracks from the json data.

### PlayerManager

Used to process the songs.

## Unit Test

### AlbumManagerTests

Test getting the extra large image (200 x 200).

### AlbumTests

Test fetching the albums and tracks from AlbumsTest.json. We can update the content of the json file as per model structure for test.

### TrackManagerTests

Test getting the `minutes:seconds` formatted string from the milliseconds.

## What should be implemented in the demo?

* Load the albums and tracks from REST API: I loaded the albums and tracks from the local file - `Albums.json` . The best option should be to fetch the data from REST API.

## What's left in the demo?

* Update the managers: I implemented the managers using singletons. The best option should be to remove the singletons in order to use dependency injections (to improve the testing).
* Manage the UISlider: For this version the UISlider in track detail page has the user interaction enable in "false". It would be nice to allow the user to manage the slider.

## Third-Party Libraries

I added the third-party libraries via Swift Package Manager
* [Kingfisher](https://github.com/onevcat/Kingfisher): A pure-Swift library for downloading and caching images from the web.
