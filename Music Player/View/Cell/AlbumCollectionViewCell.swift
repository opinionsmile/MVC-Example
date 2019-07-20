//
//  AlbumCollectionViewCell.swift
//  Music Player
//
//  Created by Created by John Lombardi on 7/20/19.
//

import UIKit
import Kingfisher

class AlbumCollectionViewCell: UICollectionViewCell {

  static let reuseId = "AlbumCollectionViewCell"

  // MARK: - UI Components
  private let albumImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.backgroundColor = .clear
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = 8.0
    imageView.clipsToBounds = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

  private let albumNameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
    label.textColor = .label
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  private let artistNameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
    label.textColor = .lightGray
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  // MARK: - Initializer
  override init(frame: CGRect) {
    super.init(frame: frame)

    setupUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - View Lifecycles
  override func prepareForReuse() {
    super.prepareForReuse()

    albumImageView.image = nil
    albumNameLabel.text = ""
    artistNameLabel.text = ""
  }

  // MARK: - Private Functions

  private func setupUI() {

    backgroundColor = .clear

    contentView.addSubview(albumImageView)
    contentView.addSubview(albumNameLabel)
    contentView.addSubview(artistNameLabel)

    NSLayoutConstraint.activate([
      albumImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      albumImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      albumImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      albumImageView.widthAnchor.constraint(equalTo: albumImageView.heightAnchor),

      albumNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      albumNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      albumNameLabel.topAnchor.constraint(equalTo: albumImageView.bottomAnchor, constant: 10),

      artistNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      artistNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      artistNameLabel.topAnchor.constraint(equalTo: albumNameLabel.bottomAnchor, constant: 5),
      artistNameLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor)
    ])
  }

  // MARK: - Public Functions

  func configure(with album: Album) {
    albumImageView.kf.setImage(with: album.artworkUrl)
    albumNameLabel.text = album.albumName
    artistNameLabel.text = album.artistName
  }
}
