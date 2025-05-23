//
//  SoundsBootcamp.swift
//  SwiftfulThinkingContinueLearning
//
//  Created by Digital Base on 19/5/25.
//

import SwiftUI
import AVKit  // A - audio , V - video


class SoundManager {
    
    static let instance = SoundManager() // Singleton
    var player: AVAudioPlayer?
    
    enum SoundOption: String {
        case tada = "Tada"
        case badum = "Badum"
    }
    
    func playSound(sound: SoundOption) {
        guard  let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch  let error  {
            print("Error playing sound. \(error.localizedDescription)")
        }
    }
}


struct SoundsBootcamp: View {
    
    
    var body: some View {
        
        VStack(spacing: 40) {
            Button("Play sound 1") {
                SoundManager.instance.playSound(sound: .tada)
            }
            
            Button("Play sound 2") {
                SoundManager.instance.playSound(sound: .badum)
                
            }
        }
    }
}

#Preview {
    SoundsBootcamp()
}
