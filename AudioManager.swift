//
//  AudioManager.swift
//  IOSStudio
//
//  Created by Isabelle Brian on 7/5/2024.
//

import AVFoundation
import UIKit

class AudioManager {
    static let shared = AudioManager()
    private var audioPlayer: AVAudioPlayer?

    private init() {}  // Singleton pattern

    func playSound(named soundFileName: String) {
        guard let asset = NSDataAsset(name: soundFileName),
              let audioPlayer = try? AVAudioPlayer(data: asset.data) else {
            print("Audio file not found")
            return
        }
        self.audioPlayer = audioPlayer
        self.audioPlayer?.play()
    }
}
