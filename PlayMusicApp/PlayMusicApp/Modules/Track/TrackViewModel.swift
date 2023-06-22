//
//  TrackViewModel.swift
//  PlayMusicApp
//
//  Created by Даниил Циркунов on 22.06.2023.
//

import Foundation

struct TrackViewModel {
    let trackName: String
    let artistName: String
    let duration: String
    let fileURL: URL
    
    init(with model: MusicTableViewModel) {
        self.trackName = model.track
        self.duration = model.duration
        self.artistName = ""
        self.fileURL = model.fileURL
    }
}
