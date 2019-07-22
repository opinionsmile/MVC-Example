//
//  TrackListViewController.swift
//  Music Player
//
//  Created by John Lombardi on 7/21/19.
//

import UIKit

protocol TrackListViewControllerDelegate: AnyObject {
  func didSelectTrack(for album: Album, track: Track)
}

class TrackListViewController: UIViewController {

  weak var delegate: TrackListViewControllerDelegate?

  // MARK: - Private Variable

  private let album: Album

  // MARK: - UI Components

  private lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.register(TrackTableViewCell.self, forCellReuseIdentifier: TrackTableViewCell.reuseId)
    tableView.tableFooterView = UIView()
    tableView.delegate = self
    tableView.dataSource = self
    tableView.translatesAutoresizingMaskIntoConstraints = false
    return tableView
  }()

  // MARK: - Initializer

  init(for album: Album) {
    self.album = album
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - View Lifecycles

  override func viewDidLoad() {
    super.viewDidLoad()

    setupUI()
  }

  // MARK: - Private Functions
  private func setupUI() {

    title = album.albumName
    navigationItem.backButtonTitle = "Back"
    view.addSubview(tableView)

    NSLayoutConstraint.activate([
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ])
  }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension TrackListViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return album.tracks.count
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: TrackTableViewCell.reuseId, for: indexPath) as! TrackTableViewCell
    cell.configure(with: album.tracks[indexPath.row])
    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)

    delegate?.didSelectTrack(for: album, track: album.tracks[indexPath.row])
  }
}
