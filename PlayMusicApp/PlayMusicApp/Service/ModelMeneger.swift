//
//  ModelMeneger.swift
//  PlayMusicApp
//
//  Created by Даниил Циркунов on 23.06.2023.
//

import Foundation
import AVFoundation

class ModelMeneger {
    func loadMusicData() -> [Track] {
        var tracks: [Track] = []
        guard let musicFolderURL = Bundle.main.url(forResource: "Music", withExtension: nil) else {
            print("Папка 'Music' не найдена.")
            return tracks
        }
        
        do {
            let musicFiles = try FileManager.default.contentsOfDirectory(at: musicFolderURL, includingPropertiesForKeys: nil)
            
            for fileURL in musicFiles {
                let fileName = fileURL.lastPathComponent
                let (trackName, atrist) = getTrackAndArtistFromFileName(fileName: fileName)
                let duration = getTrackDuration(trackURL: fileURL)
                let track = Track(track: trackName, artist: atrist, fileURL: fileURL, duration: duration)
                tracks.append(track)
            }
        } catch {
            print("Ошибка при получении списка файлов в папке Music: \(error.localizedDescription)")
        }
        return tracks
    }
}

private extension ModelMeneger {
    private func getTrackAndArtistFromFileName(fileName: String) -> (track: String, artist: String) {
        let components = fileName.components(separatedBy: "-")
        if components.count > 1 {
            let artist = components[0].trimmingCharacters(in: .whitespaces)
            let trackWithExtension = components[1].trimmingCharacters(in: .whitespaces)
            let track = trackWithExtension.replacingOccurrences(of: ".mp3", with: "")
            return (track, artist)
        }
        return ("", "")
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
