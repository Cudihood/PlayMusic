//
//  ViewController.swift
//  PlayMusicApp
//
//  Created by Даниил Циркунов on 22.06.2023.
//

import UIKit
import AVFoundation

class TrackViewController: UIViewController {
    var audioPlayer: AVAudioPlayer?
    var currentTime: TimeInterval = 0
    var totalDuration: TimeInterval = 0
    
    @IBOutlet weak var trackLable: UILabel!
    @IBOutlet weak var artistLable: UILabel!
    @IBOutlet weak var currentTimeLable: UILabel!
    @IBOutlet weak var durationLable: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var playButton: UIButton!
    
    private let model: TrackViewModel
    
    init(model: TrackViewModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    @IBAction func playButtonAction(_ sender: Any) {
        if let audioPlayer = audioPlayer {
            if audioPlayer.isPlaying {
                audioPlayer.pause()
                
            } else {
                audioPlayer.play()
                playButton.setImage(UIImage(systemName: "pause"), for: .normal)
            }
        }
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
    }
    
    @IBAction func previousButtonAction(_ sender: Any) {
    }
}

extension TrackViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        playButton.setImage(UIImage(systemName: "play"), for: .normal)
    }
}

private extension TrackViewController {
    func configure() {
        setDateUI()
        playTrack()
        
        // Установка общей продолжительности трека
        totalDuration = audioPlayer?.duration ?? 0
        
        // Запуск таймера для обновления времени трека
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTrackTime), userInfo: nil, repeats: true)

    }
    
    func setDateUI() {
        trackLable.text = model.trackName
        artistLable.text = model.artistName
        durationLable.text = model.duration
    }
    
    @objc func updateTrackTime() {
        currentTime = audioPlayer?.currentTime ?? 0
        currentTimeLable.text = formatTime(currentTime)
        
        // Обновление прогресса трека
        let progress = Float(currentTime / totalDuration)
        progressView.setProgress(progress, animated: true)
    }
    
    func formatTime(_ timeInterval: TimeInterval) -> String {
        let minutes = Int(timeInterval / 60)
        let seconds = Int(timeInterval.truncatingRemainder(dividingBy: 60))
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func playTrack() {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: model.fileURL)
            audioPlayer?.delegate = self
            audioPlayer?.prepareToPlay()
//            audioPlayer?.play()
        } catch {
            print("Ошибка при воспроизведении трека: \(error.localizedDescription)")
        }
    }
}

