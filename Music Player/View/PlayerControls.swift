//
//  PlayerControls.swift
//  MusicPlayer
//
//  Created by John Lombardi on 7/21/19.
//

import UIKit

protocol PlayerControlsDelegate: AnyObject {
  func playPressed()
  func pausePressed()
  func nextPressed()
  func prevPressed()
}

class PlayerControls: UIView {

  weak var delegate: PlayerControlsDelegate?

  public var isPrevEnabled: Bool = false {
    didSet {
      prevButton.isEnabled = isPrevEnabled
      prevButton.alpha = isPrevEnabled ? 1.0 : 0.5
    }
  }

  public var isNextEnabled: Bool = false {
    didSet {
      nextButton.isEnabled = isNextEnabled
      nextButton.alpha = isNextEnabled ? 1.0 : 0.5
    }
  }

  private var isPlaying: Bool = false

  // MARK: - UI Components
  private let playButton: UIButton = {
    let button = UIButton(type: .custom)
    button.addTarget(self, action: #selector(playButtonPressed), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  private let prevButton: UIButton = {
    let button = UIButton(type: .custom)
    button.addTarget(self, action: #selector(prevButtonPressed), for: .touchUpInside)

    let prevImage = UIImage(named: "Prev")
    button.setBackgroundImage(prevImage, for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  private let nextButton: UIButton = {
    let button = UIButton(type: .custom)
    button.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)

    let nextImage = UIImage(named: "Next")
    button.setBackgroundImage(nextImage, for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  // MARK: - Initializer

  override init(frame: CGRect) {
    super.init(frame: frame)

    setupUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Private Functions

  private func setupUI() {
    backgroundColor = .clear

    configurePlayButton()

    addSubview(playButton)
    addSubview(prevButton)
    addSubview(nextButton)

    NSLayoutConstraint.activate([
      playButton.widthAnchor.constraint(equalToConstant: 48),
      playButton.heightAnchor.constraint(equalToConstant: 48),
      playButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      playButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),

      prevButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      prevButton.widthAnchor.constraint(equalToConstant: 48),
      prevButton.heightAnchor.constraint(equalToConstant: 48),
      prevButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),

      nextButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      nextButton.widthAnchor.constraint(equalToConstant: 48),
      nextButton.heightAnchor.constraint(equalToConstant: 48),
      nextButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
    ])
  }
}

// MARK: - Private section
extension PlayerControls {

  private func configurePlayButton() {
    if isPlaying {
      let pauseImage = UIImage(named: "Pause")
      playButton.setBackgroundImage(pauseImage, for: .normal)
    } else {
      let playImage = UIImage(named: "Play")
      playButton.setBackgroundImage(playImage, for: .normal)
    }
  }
}

// MARK: - User actions
extension PlayerControls {

  @objc private func playButtonPressed() {
    isPlaying = !isPlaying
    configurePlayButton()
    if isPlaying {
      delegate?.playPressed()
    } else {
      delegate?.pausePressed()
    }
  }

  @objc private func prevButtonPressed() {
    delegate?.prevPressed()
  }

  @objc private func nextButtonPressed() {
    delegate?.nextPressed()
  }

}
