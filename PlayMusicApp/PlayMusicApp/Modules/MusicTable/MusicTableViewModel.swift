//
//  MusicTableViewModel.swift
//  PlayMusicApp
//
//  Created by Даниил Циркунов on 22.06.2023.
//

import Foundation
import AVFoundation

struct MusicTableViewModel {
    let track: String
    let fileURL: URL
    let duration: String
}

class MusicModel {
    var tracks: [MusicTableViewModel] = []
    
    func loadMusicData() {
        guard let musicFolderURL = Bundle.main.url(forResource: "Music", withExtension: nil) else {
            print("Папка 'Music' не найдена.")
            return
        }
        
        do {
            let musicFiles = try FileManager.default.contentsOfDirectory(at: musicFolderURL, includingPropertiesForKeys: nil)
            
            for fileURL in musicFiles {
                let trackTitle = fileURL.lastPathComponent
                let duration = getTrackDuration(trackURL: fileURL)
                let track = MusicTableViewModel(track: trackTitle, fileURL: fileURL, duration: duration)
                tracks.append(track)
            }
        } catch {
            print("Ошибка при получении списка файлов в папке Music: \(error.localizedDescription)")
        }
    }

    private func getArtistFromFileName(fileName: String) -> String {
        let components = fileName.components(separatedBy: "-")
        if components.count > 1 {
            let artist = components[1].trimmingCharacters(in: .whitespaces)
            return artist
        }
        return ""
    }
    
    private func getTrackDuration(trackURL: URL) -> String {
        let asset = AVURLAsset(url: trackURL)
        let duration = asset.duration
        
        let durationInSeconds = CMTimeGetSeconds(duration)
        
        if !durationInSeconds.isNaN && !durationInSeconds.isInfinite {
            let date = Date(timeIntervalSinceReferenceDate: durationInSeconds)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "mm:ss"
            return dateFormatter.string(from: date)
        } else {
            return "00:00"
        }
    }
}
