import UIKit
import SnapKit

class GalacticRestorationDifficultViewController: UIViewController {
    
    private var galacticRestorationBackgroundView = UIImageView()
    private var galacticRestorationScoreBackgroundView = UIImageView()
    private var galacticRestorationScoreLabel = UILabel()
    private var galacticRestorationEasyButton = UIButton()
    private var galacticRestorationMediumButton = UIButton()
    private var galacticRestorationHardButton = UIButton()
    private var galacticRestorationCloseButton = UIButton()
    var galacticRestorationCurrentImageIndex = 0
    
    private var galacticRestorationGlobalScore: Int {
        get { UserDefaults.standard.integer(forKey: "galacticRestorationScore") }
        set { UserDefaults.standard.set(newValue, forKey: "galacticRestorationScore") }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        galacticRestorationConfigureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        galacticRestorationScoreLabel.text = "\(galacticRestorationGlobalScore)"
    }
    
    private func galacticRestorationConfigureUI() {
        galacticRestorationSetupBackgroundView()
        galacticRestorationSetupScoreBackgroundView()
        galacticRestorationSetupScoreLabel()
        galacticRestorationSetupButtons()
    }
    
    private func galacticRestorationSetupBackgroundView() {
        galacticRestorationBackgroundView.image = UIImage(named: "Background")
        galacticRestorationBackgroundView.contentMode = .scaleAspectFill
        galacticRestorationBackgroundView.clipsToBounds = true
        galacticRestorationBackgroundView.layer.cornerRadius = 10
        view.addSubview(galacticRestorationBackgroundView)
        
        galacticRestorationBackgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func galacticRestorationSetupScoreBackgroundView() {
        galacticRestorationScoreBackgroundView.image = UIImage(named: "Score")
        galacticRestorationScoreBackgroundView.contentMode = .scaleAspectFit
        galacticRestorationScoreBackgroundView.clipsToBounds = true
        view.addSubview(galacticRestorationScoreBackgroundView)
        
        galacticRestorationScoreBackgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(50)
        }
    }
    
    private func galacticRestorationSetupScoreLabel() {
        galacticRestorationScoreLabel.font = UIFont(name: "Caprasimo", size: 20)
        galacticRestorationScoreLabel.textColor = .white
        galacticRestorationScoreLabel.textAlignment = .center
        galacticRestorationScoreLabel.text = "\(galacticRestorationGlobalScore)"
        galacticRestorationScoreBackgroundView.addSubview(galacticRestorationScoreLabel)
        
        galacticRestorationScoreLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func galacticRestorationSetupButtons() {
        galacticRestorationEasyButton.setImage(UIImage(named: "Easy"), for: .normal)
        galacticRestorationEasyButton.contentMode = .scaleAspectFit
        galacticRestorationEasyButton.layer.cornerRadius = 10
        galacticRestorationEasyButton.clipsToBounds = true
        view.addSubview(galacticRestorationEasyButton)
        
        galacticRestorationMediumButton.setImage(UIImage(named: "Normal"), for: .normal)
        galacticRestorationMediumButton.contentMode = .scaleAspectFit
        galacticRestorationMediumButton.layer.cornerRadius = 10
        galacticRestorationMediumButton.clipsToBounds = true
        view.addSubview(galacticRestorationMediumButton)
        
        galacticRestorationHardButton.setImage(UIImage(named: "Hard"), for: .normal)
        galacticRestorationHardButton.contentMode = .scaleAspectFit
        galacticRestorationHardButton.layer.cornerRadius = 10
        galacticRestorationHardButton.clipsToBounds = true
        view.addSubview(galacticRestorationHardButton)
        
        galacticRestorationCloseButton.setImage(UIImage(named: "Close"), for: .normal)
        galacticRestorationCloseButton.contentMode = .scaleAspectFit
        galacticRestorationCloseButton.layer.cornerRadius = 14
        galacticRestorationCloseButton.clipsToBounds = true
        view.addSubview(galacticRestorationCloseButton)
        
        galacticRestorationEasyButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(galacticRestorationMediumButton.snp.top).offset(-50)
            make.width.equalTo(200)
            make.height.equalTo(60)
        }
        
        galacticRestorationMediumButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(60)
        }
        
        galacticRestorationHardButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(galacticRestorationMediumButton.snp.bottom).offset(50)
            make.width.equalTo(200)
            make.height.equalTo(60)
        }
        
        galacticRestorationCloseButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.left.equalToSuperview().inset(10)
            make.width.height.equalTo(50)
        }
        
        galacticRestorationEasyButton.addTarget(self, action: #selector(galacticRestorationTapEasyButton), for: .touchUpInside)
        addGalacticSound(button: galacticRestorationEasyButton)
        galacticRestorationMediumButton.addTarget(self, action: #selector(galacticRestorationTapMediumButton), for: .touchUpInside)
        addGalacticSound(button: galacticRestorationMediumButton)
        galacticRestorationHardButton.addTarget(self, action: #selector(galacticRestorationTapHardButton), for: .touchUpInside)
        addGalacticSound(button: galacticRestorationHardButton)
        galacticRestorationCloseButton.addTarget(self, action: #selector(galacticRestorationCloseButtonTapped), for: .touchUpInside)
        addGalacticSound(button: galacticRestorationCloseButton)
    }

    
    @objc private func galacticRestorationTapEasyButton() {
        let selectedGameViewController: UIViewController
        switch galacticRestorationCurrentImageIndex {
        case 0:
            selectedGameViewController = GladiatorController()
            (selectedGameViewController as? GladiatorController)?.galacticLevel = 200
        case 1:
            selectedGameViewController = ChineseGame()
            (selectedGameViewController as? ChineseGame)?.galacticRestorationShuffleInterval = 2
        default:
            return
        }
        
        selectedGameViewController.modalPresentationStyle = .fullScreen
        present(selectedGameViewController, animated: true, completion: nil)
    }

    @objc private func galacticRestorationTapMediumButton() {
        let selectedGameViewController: UIViewController
        switch galacticRestorationCurrentImageIndex {
        case 0:
            selectedGameViewController = GladiatorController()
            (selectedGameViewController as? GladiatorController)?.galacticLevel = 150
        case 1:
            selectedGameViewController = ChineseGame()
            (selectedGameViewController as? ChineseGame)?.galacticRestorationShuffleInterval = 1.5
        default:
            return
        }
        
        selectedGameViewController.modalPresentationStyle = .fullScreen
        present(selectedGameViewController, animated: true, completion: nil)
    }

    @objc private func galacticRestorationTapHardButton() {
        let selectedGameViewController: UIViewController
        switch galacticRestorationCurrentImageIndex {
        case 0:
            selectedGameViewController = GladiatorController()
            (selectedGameViewController as? GladiatorController)?.galacticLevel = 100
        case 1:
            selectedGameViewController = ChineseGame()
            (selectedGameViewController as? ChineseGame)?.galacticRestorationShuffleInterval = 1
        default:
            return
        }
        
        selectedGameViewController.modalPresentationStyle = .fullScreen
        present(selectedGameViewController, animated: true, completion: nil)
    }


    
    @objc private func galacticRestorationCloseButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
}
