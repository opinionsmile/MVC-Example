//
//  AlbumListViewController.swift
//  Music Player
//
//  Created by John Lombardi on 7/18/19.
//

import UIKit

import UIKit

protocol AlbumListViewControllerDelegate: AnyObject {
  func didSelectAlbum(_ album: Album)
}

class AlbumListViewController: UIViewController {

  weak var delegate: AlbumListViewControllerDelegate?

  // MARK: - Private Variable

  private var albums: [Album] = []

  private let numberOfCellsInARow = 2

  // MARK: - UI Components

  private lazy var collectionView: UICollectionView = {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = .vertical

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    collectionView.backgroundColor = .clear
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.isUserInteractionEnabled = true
    collectionView.register(AlbumCollectionViewCell.self, forCellWithReuseIdentifier: AlbumCollectionViewCell.reuseId)
    collectionView.showsVerticalScrollIndicator = false
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    return collectionView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    setupUI()
    loadAlbums()
  }

  // MARK: - Private Functions

  private func setupUI() {

    title = "Albums"
    view.backgroundColor = .systemBackground
    view.addSubview(collectionView)

    NSLayoutConstraint.activate([
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      collectionView.topAnchor.constraint(equalTo: view.topAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }

  private func loadAlbums() {
    if let path = Bundle.main.path(forResource: "Albums", ofType: "json") {
      do {
        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        let processedData = try JSONDecoder().decode(AlbumsResponse.self, from: data)
        albums = Album.getAlbumsWith(processedData)
        collectionView.reloadData()
      } catch {
        print("Failed to load the albums - \(error.localizedDescription)")
      }
    }
  }

  /**
   * Get album cell width
   */
  private func getAlbumCellWidth() -> CGFloat {
    let screenWidth: CGFloat = UIScreen.main.bounds.width
    let cellContainerWidth: CGFloat = screenWidth - 16 * (CGFloat(numberOfCellsInARow-1)) - 16 * CGFloat(numberOfCellsInARow)
    return cellContainerWidth / CGFloat(numberOfCellsInARow)
  }
}

// MARK: - UICollectionViewDelegate (with UICollectionViewDelegateFlowLayout)
extension AlbumListViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = getAlbumCellWidth()

    return CGSize(width: width, height: width * 1.5)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 24, left: 16, bottom: 24, right: 16)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 16
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 16
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    delegate?.didSelectAlbum(albums[indexPath.item])
  }
}

// MARK: - UICollectionViewDataSource
extension AlbumListViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return albums.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumCollectionViewCell.reuseId, for: indexPath) as! AlbumCollectionViewCell
    cell.configure(with: albums[indexPath.item])
    return cell
  }
}
