//
//  MusicTableViewModel.swift
//  PlayMusicApp
//
//  Created by Даниил Циркунов on 22.06.2023.
//

import Foundation

class Track {
    let track: String
    let artist: String
    let fileURL: URL
    let duration: String
    
    init(track: String, artist: String, fileURL: URL, duration: String) {
        self.track = track
        self.artist = artist
        self.fileURL = fileURL
        self.duration = duration
    }
}


