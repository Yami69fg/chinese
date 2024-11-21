import UIKit
import SpriteKit
import GameplayKit

class GladiatorController: UIViewController {
    
    weak var GladiatorScene: Gladiator?
    
    var galacticLevel = 1
    
    private let galacticScoreBackgroundImageView = UIImageView()
    private let galacticGlobalScoreLabel = UILabel()
    private let galacticPauseButton = UIButton()
    
    private var galacticRestorationGlobalScore: Int {
        get { UserDefaults.standard.integer(forKey: "galacticRestorationScore") }
        set { UserDefaults.standard.set(newValue, forKey: "galacticRestorationScore") }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = SKView(frame: view.frame)
        
        if let view = self.view as? SKView {
            let openGladiatorViewController = Gladiator(size: view.bounds.size)
            self.GladiatorScene = openGladiatorViewController
            openGladiatorViewController.GalacticRestoratioVerticalNodeHeight = CGFloat(galacticLevel)
            openGladiatorViewController.GalacticRestoratioController = self
            openGladiatorViewController.scaleMode = .aspectFill
            view.presentScene(openGladiatorViewController)
        }
        
        galacticScoreBackgroundImageView.image = UIImage(named: "Score")
        view.addSubview(galacticScoreBackgroundImageView)
        galacticScoreBackgroundImageView.snp.makeConstraints { galacticMake in
            galacticMake.centerX.equalToSuperview()
            galacticMake.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            galacticMake.width.equalTo(150)
            galacticMake.height.equalTo(55)
        }
        
        galacticGlobalScoreLabel.text = "\(galacticRestorationGlobalScore)"
        galacticGlobalScoreLabel.textAlignment = .center
        galacticGlobalScoreLabel.font = UIFont(name: "Caprasimo", size: 22)
        galacticGlobalScoreLabel.textColor = .white
        galacticScoreBackgroundImageView.addSubview(galacticGlobalScoreLabel)
        galacticGlobalScoreLabel.snp.makeConstraints { galacticMake in
            galacticMake.center.equalToSuperview()
        }
        
        galacticPauseButton.setImage(UIImage(named: "Setting"), for: .normal)
        galacticPauseButton.addTarget(self, action: #selector(galacticRestorationButtonPress), for: .touchUpInside)
        addGalacticSound(button: galacticPauseButton)
        view.addSubview(galacticPauseButton)
        galacticPauseButton.snp.makeConstraints { galacticMake in
            galacticMake.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            galacticMake.right.equalToSuperview().inset(10)
            galacticMake.width.height.equalTo(55)
        }
    }
    
    func galacticRestorationOver(galacticRestorationScore:Int) {
        GladiatorScene?.GalacticRestoratioPauseGame()
        let galacticRestorationController = GalacticRestorationGameOverViewController()
        galacticRestorationController.galacticRestorationScore = galacticRestorationScore
        galacticRestorationController.galacticRestorationOnReturnToMenu = { [weak self] in
            self?.dismiss(animated: false)
        }
        galacticRestorationController.galacticRestorationOnRestart = { [weak self] in
            self?.GladiatorScene?.GalacticRestoratioRestartGame()
        }
        galacticRestorationController.modalPresentationStyle = .overCurrentContext
        self.present(galacticRestorationController, animated: false, completion: nil)
    }
    
    @objc private func galacticRestorationButtonPress() {
        GladiatorScene?.GalacticRestoratioPauseGame()
        let galacticRestorationController = GalacticRestorationControllSoundViewController()
        galacticRestorationController.galacticRestorationOnReturnToMenu = { [weak self] in
            self?.dismiss(animated: false)
        }
        galacticRestorationController.galacticRestorationResume = { [weak self] in
            self?.GladiatorScene?.GalacticRestoratioResumeGame()
        }
        galacticRestorationController.modalPresentationStyle = .overCurrentContext
        self.present(galacticRestorationController, animated: false, completion: nil)
    }
    
    func galacticScore(){
        galacticRestorationGlobalScore+=1
        galacticGlobalScoreLabel.text = "\(galacticRestorationGlobalScore)"
    }

}
