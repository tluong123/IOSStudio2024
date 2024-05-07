//
//  AudioManager.swift
//  IOSStudio
//
//  Created by Isabelle Brian on 7/5/2024.
//

import Foundation
import AVFoundation

class AudioManager {
    static let shared = AudioManager()
    private var audioPlayer: AVAudioPlayer?

    private init() {}  // Ensures AudioManager cannot be initialized from outside

    func playSound(named soundFileName: String) {
        guard let url = Bundle.main.url(forResource: soundFileName, withExtension: nil) else {
            print("Audio file not found")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Could not load file:", error)
        }
    }
}

