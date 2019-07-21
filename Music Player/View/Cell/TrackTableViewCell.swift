//
//  TrackTableViewCell.swift
//  Music Player
//
//  Created by John Lombardi on 7/21/19.
//

import UIKit

class TrackTableViewCell: UITableViewCell {

  static let reuseId = "TrackTableViewCell"

  // MARK: - UI Components

  private let trackNameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
    label.textColor = .label
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  private let durationLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
    label.textColor = .label
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  // MARK: - Initializer
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    setupUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - View Lifecycles
  override func prepareForReuse() {
    super.prepareForReuse()

    trackNameLabel.text = ""
    durationLabel.text = ""
  }

  // MARK: - Private Functions

  private func setupUI() {

    backgroundColor = .clear

    contentView.addSubview(trackNameLabel)
    contentView.addSubview(durationLabel)

    NSLayoutConstraint.activate([
      trackNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      trackNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -80),
      trackNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
      trackNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

      durationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      durationLabel.firstBaselineAnchor.constraint(equalTo: trackNameLabel.firstBaselineAnchor),
    ])
  }

  // MARK: - Public Functions

  func configure(with track: Track) {
    trackNameLabel.text = track.trackName
    durationLabel.text = track.trackDuration
  }

}
