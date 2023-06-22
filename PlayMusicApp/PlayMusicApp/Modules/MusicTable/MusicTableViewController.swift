//
//  MusicTableViewController.swift
//  PlayMusicApp
//
//  Created by Даниил Циркунов on 22.06.2023.
//

import UIKit
import AVFoundation

class MusicTableViewController: UITableViewController {
    
    private var audioPlayer = AVAudioPlayer()
    private let musicModel = MusicModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        musicModel.loadMusicData()
        configure()
    }
}

extension MusicTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicModel.tracks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MusicTableViewCell.reuseIdentifier, for: indexPath) as? MusicTableViewCell else {
            return UITableViewCell()
        }
        let track = MusicTableViewCellModel(with: musicModel.tracks[indexPath.row])
        cell.configure(with: track)
        return cell
    }
}

extension MusicTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let track = TrackViewModel(with: musicModel.tracks[indexPath.row])
        let trackVC = TrackViewController(model: track)
        trackVC.audioPlayer = self.audioPlayer
        self.navigationController?.pushViewController(trackVC, animated: true)
    }
}

private extension MusicTableViewController {
    func configure() {
        self.title = "Музыка"
        self.view.backgroundColor = Constants.Color.background
        self.tableView.register(MusicTableViewCell.self, forCellReuseIdentifier: MusicTableViewCell.reuseIdentifier)
    }
}
