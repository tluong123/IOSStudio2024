//
//  SpeechSynthezierService.swift
//  IOSStudio
//
//  Created by Isabelle Brian on 16/4/2024.
//

import Foundation
import AVFoundation

class SpeechSynthesizerService {
    static let shared = SpeechSynthesizerService()
    private let synthesizer = AVSpeechSynthesizer()

    private init() {}

    func speak(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        synthesizer.speak(utterance)
    }
}
