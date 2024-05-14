import AVFoundation
import UIKit

class AudioManager {
    static let shared = AudioManager()
    private var audioPlayer: AVAudioPlayer?
    private var backgroundAudioPlayer: AVAudioPlayer?

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
    
    func playBackgroundMusic(named soundFileName: String) {
        guard let asset = NSDataAsset(name: soundFileName),
              let backgroundAudioPlayer = try? AVAudioPlayer(data: asset.data) else {
            print("Background music file not found")
            return
        }
        self.backgroundAudioPlayer = backgroundAudioPlayer
        self.backgroundAudioPlayer?.numberOfLoops = -1 // Loop indefinitely
        self.backgroundAudioPlayer?.play()
    }
    
    func stopBackgroundMusic() {
        backgroundAudioPlayer?.stop()
    }
    
    func setBackgroundMusicVolume(to volume: Float) {
        backgroundAudioPlayer?.volume = volume
    }
}
