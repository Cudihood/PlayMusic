//
//  MusicTableViewCellModel.swift
//  PlayMusicApp
//
//  Created by Даниил Циркунов on 22.06.2023.
//

import UIKit

struct MusicTableViewCellModel {
    let track: String
    let duration: String
    
    init(with model: MusicTableViewModel) {
        self.track = model.track
        self.duration = model.duration
    }
}
