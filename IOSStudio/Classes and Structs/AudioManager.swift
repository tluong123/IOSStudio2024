import AVFoundation
import UIKit

class AudioManager {
    static let shared = AudioManager()
    private var audioPlayer: AVAudioPlayer?
    private var backgroundAudioPlayer: AVAudioPlayer?
    private var useFirstSoundtrack = true  // State variable to toggle between soundtracks

    private init() {}

    func playSound(named soundFileName: String) {
        guard let asset = NSDataAsset(name: soundFileName),
              let audioPlayer = try? AVAudioPlayer(data: asset.data) else {
            print("Audio file not found")
            return
        }
        self.audioPlayer = audioPlayer
        self.audioPlayer?.play()
    }

    func playBackgroundMusic() {
        let soundtrack = useFirstSoundtrack ? "BackgroundSound" : "BackgroundSound2"
        guard let asset = NSDataAsset(name: soundtrack),
              let backgroundAudioPlayer = try? AVAudioPlayer(data: asset.data) else {
            print("Background music file not found")
            return
        }
        self.backgroundAudioPlayer = backgroundAudioPlayer
        self.backgroundAudioPlayer?.numberOfLoops = -1 // Loop indefinitely
        self.backgroundAudioPlayer?.play()

        useFirstSoundtrack.toggle()  // Toggle for next time
    }

    func stopBackgroundMusic() {
        backgroundAudioPlayer?.stop()
    }

    func setBackgroundMusicVolume(to volume: Float) {
        backgroundAudioPlayer?.volume = volume
    }
}
