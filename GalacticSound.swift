import UIKit
import SpriteKit
import AVFoundation

class GalacticSound {
    
    static let shared = GalacticSound()
    private var audio: AVAudioPlayer?

    private init() {}
    
    func playSoundPress() {
        let isSound = UserDefaults.standard.bool(forKey: "sound")
        if isSound {
            DispatchQueue.global().async {
                guard let sound = Bundle.main.url(forResource: "Button", withExtension: "mp3") else { return }
                self.audio = try? AVAudioPlayer(contentsOf: sound)
                self.audio?.prepareToPlay()
                self.audio?.play()
            }
        }
        
        let isVibration = UserDefaults.standard.bool(forKey: "sound")
        if isVibration {
            let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
            feedbackGenerator.impactOccurred()
        }
    }
    
    func playOverSound() {
        let isSound = UserDefaults.standard.bool(forKey: "sound")
        if isSound {
            DispatchQueue.global().async {
                guard let sound = Bundle.main.url(forResource: "Over", withExtension: "mp3") else { return }
                self.audio = try? AVAudioPlayer(contentsOf: sound)
                self.audio?.prepareToPlay()
                self.audio?.play()
            }
        }
    }
    

}

extension UIViewController {
    
    func addGalacticSound(button: UIButton) {
        button.addTarget(self, action: #selector(handleButtonTouchDown(sender:)), for: .touchDown)
    }
    
    func overGalacticSound() {
        GalacticSound.shared.playOverSound()
    }
    
    func galacticSound() {
        GalacticSound.shared.playSoundPress()
    }
    
    @objc private func handleButtonTouchDown(sender: UIButton) {
        GalacticSound.shared.playSoundPress()
    }
}

extension SKScene {
    func galacticSound() {
        GalacticSound.shared.playSoundPress()
    }
    
}
