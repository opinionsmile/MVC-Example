//
//  PlayerTrackDuration.swift
//  MusicPlayer
//
//  Created by John Lombardi on 7/21/19.
//

import UIKit

class PlayerTrackDuration: UIView {

  private let slider: UISlider = {
    let slider = UISlider()
    slider.tintColor = .label
    slider.thumbTintColor = .label
    slider.isUserInteractionEnabled = false
    slider.translatesAutoresizingMaskIntoConstraints = false
    return slider
  }()

  private let currentDuration: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
    label.textColor = .label
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  private let totalDuration: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
    label.textColor = .label
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  public var current: Int? {
    didSet {
      guard let current = current else { return }
      currentDuration.text = TrackManager.shared.getTrackTimemmssFormatWith(trackTimeMillis: current * 1000)
      DispatchQueue.main.async() {
        self.slider.setValue(Float(current * 1000), animated: true)
      }
    }
  }

  public var total: Double? {
    didSet {
      guard let total = total, !(total.isNaN || total.isInfinite) else { return }
      totalDuration.text = TrackManager.shared.getTrackTimemmssFormatWith(trackTimeMillis: Int(total * 1000.0))
      slider.maximumValue = Float(total * 1000.0)
    }
  }

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

    addSubview(slider)
    addSubview(currentDuration)
    addSubview(totalDuration)

    NSLayoutConstraint.activate([
      slider.widthAnchor.constraint(equalTo: self.widthAnchor),
      slider.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
      slider.heightAnchor.constraint(equalToConstant: 10),

      currentDuration.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      currentDuration.bottomAnchor.constraint(equalTo: self.bottomAnchor),

      totalDuration.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      totalDuration.bottomAnchor.constraint(equalTo: self.bottomAnchor),
    ])
  }
}
