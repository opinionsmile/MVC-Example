//
//  TrackDetailViewController.swift
//  MusicPlayer
//
//  Created by John Lombardi on 7/21/19.
//

import UIKit

class TrackDetailViewController: UIViewController {

  // MARK: - Private Variables

  private let album: Album
  private var track: Track

  // MARK: - UI Components

  private lazy var artworkImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.kf.setImage(with: album.artworkUrl)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

  private let trackNameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
    label.numberOfLines = 0
    label.textColor = .label
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  private lazy var artistNameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    label.numberOfLines = 0
    label.text = album.artistName
    label.textColor = .lightGray
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  private let trackDuration: PlayerTrackDuration = {
    let trackDuration = PlayerTrackDuration()
    trackDuration.translatesAutoresizingMaskIntoConstraints = false
    return trackDuration
  }()

  private lazy var playerControls: PlayerControls = {
    let playerControls = PlayerControls()
    playerControls.delegate = self
    playerControls.translatesAutoresizingMaskIntoConstraints = false
    return playerControls
  }()

  // MARK: - Initializer

  init(album: Album, track: Track) {
    self.album = album
    self.track = track
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - View Lifecycles

  override func viewDidLoad() {
    super.viewDidLoad()

    setupUI()
    updateUI()

    PlayerManager.shared.delegate = self
    PlayerManager.shared.prepare(with: track.previewUrl)
  }

  override func viewWillDisappear(_ animated: Bool) {
    PlayerManager.shared.delegate = nil
    PlayerManager.shared.pause()
  }

  // MARK: - Private Functions

  private func setupUI() {

    view.backgroundColor = .systemBackground

    view.addSubview(artworkImageView)
    view.addSubview(trackNameLabel)
    view.addSubview(artistNameLabel)
    view.addSubview(trackDuration)
    view.addSubview(playerControls)

    NSLayoutConstraint.activate([

      artworkImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 64),
      artworkImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -64),
      artworkImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
      artworkImageView.heightAnchor.constraint(equalTo: artworkImageView.widthAnchor),

      trackNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 64),
      trackNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -64),
      trackNameLabel.topAnchor.constraint(equalTo: artworkImageView.bottomAnchor, constant: 32),

      artistNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 64),
      artistNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -64),
      artistNameLabel.topAnchor.constraint(equalTo: trackNameLabel.bottomAnchor, constant: 16),

      trackDuration.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
      trackDuration.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
      trackDuration.heightAnchor.constraint(equalToConstant: 48),

      playerControls.leadingAnchor.constraint(equalTo: trackDuration.leadingAnchor),
      playerControls.trailingAnchor.constraint(equalTo: trackDuration.trailingAnchor),
      playerControls.topAnchor.constraint(equalTo: trackDuration.bottomAnchor, constant: 32),
      playerControls.heightAnchor.constraint(equalToConstant: 48),
      playerControls.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -64),
    ])
  }

  private func updateUI() {
    trackNameLabel.text = track.trackName
    let isFirstTrackSelected =  (track.trackId == album.tracks.compactMap({ $0.trackId }).first)
    let isLastTrackSelected =   (track.trackId == album.tracks.compactMap({ $0.trackId }).last)

    playerControls.isPrevEnabled = !isFirstTrackSelected
    playerControls.isNextEnabled = !isLastTrackSelected
  }

  // MARK: - Other Functions
  private func nextTrack() {
    guard let currentTrackIndex = album.tracks.firstIndex(where: { $0.trackId == track.trackId }) else { return }

    let nextTrackIndex = currentTrackIndex + 1
    if !album.tracks.indices.contains(nextTrackIndex) { return }

    self.track = album.tracks[nextTrackIndex]
    PlayerManager.shared.prepare(with: self.track.previewUrl)
    PlayerManager.shared.play()

    updateUI()
  }

  private func prevTrack() {
    guard let currentTrackIndex = album.tracks.firstIndex(where: { $0.trackId == track.trackId }) else { return }

    let prevTrackIndex = currentTrackIndex - 1
    if !album.tracks.indices.contains(prevTrackIndex) { return }

    self.track = album.tracks[prevTrackIndex]
    PlayerManager.shared.prepare(with: self.track.previewUrl)
    PlayerManager.shared.play()

    updateUI()
  }
}

// MARK: - PlayerControlsDelegate

extension TrackDetailViewController: PlayerControlsDelegate {
  func playPressed() {
    PlayerManager.shared.play()
  }

  func pausePressed() {
    PlayerManager.shared.pause()
  }

  func nextPressed() {
    nextTrack()
  }

  func prevPressed() {
    prevTrack()
  }
}

// MARK: - PlayerManagerDelegate

extension TrackDetailViewController: PlayerManagerDelegate {
  func didFinishPlaying() {
    nextTrack()
  }

  func currentTime(_ seconds: Int) {
    trackDuration.current = seconds
  }

  func totalSecondsDuration(_ seconds: Double) {
    trackDuration.total = seconds
  }
}
