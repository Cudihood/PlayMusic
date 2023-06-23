//
//  ViewController.swift
//  PlayMusicApp
//
//  Created by Даниил Циркунов on 22.06.2023.
//

import UIKit
import AVFoundation

final class TrackViewController: UIViewController {
    var selectedTrackIndex: Int = 0
    
    @IBOutlet weak var trackLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var playButton: UIButton!
    
    private var audioPlayer: AVAudioPlayer?
    private var currentTime: TimeInterval = 0
    private var totalDuration: TimeInterval = 0
    private var currentIndex: Int = 0
    private var isPlaying: Bool
    
    private let tracks: [Track]
    
    init(tracks: [Track]) {
        self.tracks = tracks
        self.isPlaying = ((audioPlayer?.isPlaying) != nil)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateView()
    }
    
    @IBAction func playButtonAction(_ sender: Any) {
        if let audioPlayer = audioPlayer {
            if audioPlayer.isPlaying {
                audioPlayer.pause()
                isPlaying = false
            } else {
                audioPlayer.play()
                isPlaying = true
            }
            updatePlayButtonImage()
        }
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        nextTrack()
    }
    
    @IBAction func previousButtonAction(_ sender: Any) {
        previousTrack()
    }
}

extension TrackViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        isPlaying = false
        updatePlayButtonImage()
    }
}

private extension TrackViewController {
    func configure() {
        setDateUI()
        
        if audioPlayer == nil {
            playTrack(index: selectedTrackIndex)
        }
        
        totalDuration = audioPlayer?.duration ?? 0
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTrackTime), userInfo: nil, repeats: true)

    }
    
    func setDateUI() {
        trackLabel.text = tracks[selectedTrackIndex].track
        artistLabel.text = tracks[selectedTrackIndex].artist
        durationLabel.text = tracks[selectedTrackIndex].duration
    }
    
    @objc func updateTrackTime() {
        guard let audioPlayer = audioPlayer else {
            return
        }

        currentTime = audioPlayer.currentTime
        currentTimeLabel.text = formatTime(currentTime)
        
        let progress = Float(currentTime / totalDuration)
        progressView.setProgress(progress, animated: true)
    }
    
    func formatTime(_ timeInterval: TimeInterval) -> String {
        let minutes = Int(timeInterval / 60)
        let seconds = Int(timeInterval.truncatingRemainder(dividingBy: 60))
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func playTrack(index: Int) {
        do {
            currentIndex = index
            audioPlayer = try AVAudioPlayer(contentsOf: tracks[index].fileURL)
            audioPlayer?.delegate = self
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
            isPlaying = true
        } catch {
            print("Ошибка при воспроизведении трека: \(error.localizedDescription)")
        }
    }
    
    func updatePlayButtonImage() {
        let imageName = isPlaying ? "pause" : "play"
        playButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    func updateTrackProgress() {
        guard let audioPlayer = audioPlayer else {
            return
        }
        
        currentTime = audioPlayer.currentTime
        self.currentTimeLabel.text = formatTime(currentTime)
        
        let progress = Float(currentTime / totalDuration)
        progressView.setProgress(progress, animated: false)
    }
    
    func updateView() {
        if currentIndex != selectedTrackIndex {
            playTrack(index: selectedTrackIndex)
            configure()
        }
        updatePlayButtonImage()
        updateTrackProgress()
    }
    
    func nextTrack() {
        if currentIndex == (tracks.count - 1) {
            selectedTrackIndex = 0
        } else {
            selectedTrackIndex += 1
        }
        updateView()
    }
    
    func previousTrack() {
        if currentIndex == 0 {
            selectedTrackIndex = tracks.count - 1
        } else {
            selectedTrackIndex -= 1
        }
        updateView()
    }
}

