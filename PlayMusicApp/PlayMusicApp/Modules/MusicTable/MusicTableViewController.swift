//
//  MusicTableViewController.swift
//  PlayMusicApp
//
//  Created by Даниил Циркунов on 22.06.2023.
//

import UIKit

final class MusicTableViewController: UITableViewController {
    private var trackView: TrackViewController!
    
    private var tracks: [Track]
     
    init(tracks: [Track]) {
        self.tracks = tracks
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

extension MusicTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MusicTableViewCell.reuseIdentifier, for: indexPath) as? MusicTableViewCell else {
            return UITableViewCell()
        }
        let track = MusicTableViewCellModel(with: tracks[indexPath.row])
        cell.configure(with: track)
        return cell
    }
}

extension MusicTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        trackView.selectedTrackIndex = indexPath.row
        present(trackView, animated: true)
    }
}

private extension MusicTableViewController {
    func configure() {
        self.title = "Музыка"
        self.view.backgroundColor = Constants.Color.background
        self.tableView.register(MusicTableViewCell.self, forCellReuseIdentifier: MusicTableViewCell.reuseIdentifier)
        self.trackView = TrackViewController(tracks: tracks)
    }
}
