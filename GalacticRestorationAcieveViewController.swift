import UIKit
import SnapKit

class GalacticRestorationAcieveViewController: UIViewController {
    
    private let galacticRestorationBackdropImageView = UIImageView()
    private let galacticRestorationCenterImageView = UIImageView()
    private let galacticRestorationTopImageView = UIImageView()
    private let galacticRestorationLeftButton = UIButton()
    private let galacticRestorationRightButton = UIButton()
    private let galacticRestorationCloseButton = UIButton()
    private let galacticRestorationCheckButton = UIButton()
    private let galacticRestorationScoreBackgroundImageView = UIImageView()
    private let galacticRestorationScoreLabel = UILabel()
    
    private let galacticRestorationImageNames = ["Achieve1", "Ahieve2", "Achieve3"]
    private let galacticRestorationTopImageNames = ["AchieveImg1", "AchieveImg2", "AchieveImg3"]
    private var galacticRestorationCurrentImageIndex = 0
    
    private var galacticRestorationGlobalScore: Int {
        get { UserDefaults.standard.integer(forKey: "galacticRestorationScore") }
        set { UserDefaults.standard.set(newValue, forKey: "galacticRestorationScore") }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        galacticRestorationScoreLabel.text = "\(galacticRestorationGlobalScore)"
        galacticRestorationConfigureUI()
        galacticRestorationUpdateCenterImage()
        galacticRestorationUpdateTopImage()
        galacticRestorationSetupActions()
        galacticRestorationUpdateAchievementStatus()
    }
    
    private func galacticRestorationConfigureUI() {
        galacticRestorationSetupBackdrop()
        galacticRestorationSetupTopImage()
        galacticRestorationSetupCenterImage()
        galacticRestorationSetupScoreView()
        galacticRestorationSetupCloseButton()
        galacticRestorationSetupLeftButton()
        galacticRestorationSetupRightButton()
        galacticRestorationSetupCheckButton()
    }
    
    private func galacticRestorationSetupBackdrop() {
        galacticRestorationBackdropImageView.image = UIImage(named: "Background")
        galacticRestorationBackdropImageView.contentMode = .scaleAspectFill
        view.addSubview(galacticRestorationBackdropImageView)
        galacticRestorationBackdropImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func galacticRestorationSetupTopImage() {
        galacticRestorationTopImageView.contentMode = .scaleAspectFit
        view.addSubview(galacticRestorationTopImageView)
        galacticRestorationTopImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(100)
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(galacticRestorationTopImageView.snp.width)
        }
    }
    
    private func galacticRestorationSetupCenterImage() {
        galacticRestorationCenterImageView.contentMode = .scaleAspectFit
        view.addSubview(galacticRestorationCenterImageView)
        galacticRestorationCenterImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(galacticRestorationCenterImageView.snp.width)
        }
    }
    
    private func galacticRestorationSetupScoreView() {
        galacticRestorationScoreBackgroundImageView.image = UIImage(named: "Score")
        galacticRestorationScoreBackgroundImageView.contentMode = .scaleAspectFit
        view.addSubview(galacticRestorationScoreBackgroundImageView)
        galacticRestorationScoreBackgroundImageView.addSubview(galacticRestorationScoreLabel)
        
        galacticRestorationScoreLabel.font = UIFont(name: "Caprasimo", size: 20)
        galacticRestorationScoreLabel.textColor = .white
        galacticRestorationScoreLabel.textAlignment = .center
        
        galacticRestorationScoreBackgroundImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(50)
        }
        
        galacticRestorationScoreLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func galacticRestorationSetupCloseButton() {
        galacticRestorationCloseButton.setImage(UIImage(named: "Close"), for: .normal)
        galacticRestorationCloseButton.contentMode = .scaleAspectFit
        galacticRestorationCloseButton.layer.cornerRadius = 14
        galacticRestorationCloseButton.clipsToBounds = true
        view.addSubview(galacticRestorationCloseButton)
        galacticRestorationCloseButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.left.equalToSuperview().inset(10)
            make.width.height.equalTo(50)
        }
    }
    
    private func galacticRestorationSetupLeftButton() {
        galacticRestorationLeftButton.setImage(UIImage(named: "ToBack"), for: .normal)
        galacticRestorationLeftButton.contentMode = .scaleAspectFit
        galacticRestorationLeftButton.layer.cornerRadius = 20
        galacticRestorationLeftButton.clipsToBounds = true
        view.addSubview(galacticRestorationLeftButton)
        galacticRestorationLeftButton.snp.makeConstraints { make in
            make.centerY.equalTo(galacticRestorationCenterImageView)
            make.right.equalTo(galacticRestorationCenterImageView.snp.left).offset(-20)
            make.width.height.equalTo(55)
        }
    }
    
    private func galacticRestorationSetupRightButton() {
        galacticRestorationRightButton.setImage(UIImage(named: "ToNext"), for: .normal)
        galacticRestorationRightButton.contentMode = .scaleAspectFit
        galacticRestorationRightButton.layer.cornerRadius = 20
        galacticRestorationRightButton.clipsToBounds = true
        view.addSubview(galacticRestorationRightButton)
        galacticRestorationRightButton.snp.makeConstraints { make in
            make.centerY.equalTo(galacticRestorationCenterImageView)
            make.left.equalTo(galacticRestorationCenterImageView.snp.right).offset(20)
            make.width.height.equalTo(55)
        }
    }
    
    private func galacticRestorationSetupCheckButton() {
        galacticRestorationCheckButton.setImage(UIImage(named: "Select"), for: .normal)
        galacticRestorationCheckButton.contentMode = .scaleAspectFit
        galacticRestorationCheckButton.layer.cornerRadius = 10
        galacticRestorationCheckButton.clipsToBounds = true
        view.addSubview(galacticRestorationCheckButton)
        galacticRestorationCheckButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(galacticRestorationCenterImageView.snp.bottom).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
    }
    
    private func galacticRestorationUpdateCenterImage() {
        galacticRestorationCenterImageView.image = UIImage(named: galacticRestorationImageNames[galacticRestorationCurrentImageIndex])
        galacticRestorationUpdateAchievementStatus()
    }
    
    private func galacticRestorationUpdateTopImage() {
        galacticRestorationTopImageView.image = UIImage(named: galacticRestorationTopImageNames[galacticRestorationCurrentImageIndex])
    }
    
    private func galacticRestorationUpdateAchievementStatus() {
        let isConditionMet = galacticRestorationCheckConditionForCurrentImage()
        galacticRestorationCenterImageView.alpha = isConditionMet ? 1.0 : 0.5
    }
    
    private func galacticRestorationSetupActions() {
        galacticRestorationLeftButton.addTarget(self, action: #selector(galacticRestorationLeftButtonTapped), for: .touchUpInside)
        addGalacticSound(button: galacticRestorationLeftButton)
        galacticRestorationRightButton.addTarget(self, action: #selector(galacticRestorationRightButtonTapped), for: .touchUpInside)
        addGalacticSound(button: galacticRestorationRightButton)
        galacticRestorationCloseButton.addTarget(self, action: #selector(galacticRestorationCloseButtonTapped), for: .touchUpInside)
        addGalacticSound(button: galacticRestorationCloseButton)
        galacticRestorationCheckButton.addTarget(self, action: #selector(galacticRestorationCheckButtonTapped), for: .touchUpInside)
        addGalacticSound(button: galacticRestorationCheckButton)
    }
    
    @objc private func galacticRestorationLeftButtonTapped() {
        if galacticRestorationCurrentImageIndex > 0 {
            galacticRestorationCurrentImageIndex -= 1
            galacticRestorationUpdateCenterImage()
            galacticRestorationUpdateTopImage()
        }
    }
    
    @objc private func galacticRestorationRightButtonTapped() {
        if galacticRestorationCurrentImageIndex < galacticRestorationImageNames.count - 1 {
            galacticRestorationCurrentImageIndex += 1
            galacticRestorationUpdateCenterImage()
            galacticRestorationUpdateTopImage()
        }
    }
    
    @objc private func galacticRestorationCloseButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func galacticRestorationCheckButtonTapped() {
        let message = galacticRestorationAchievementMessageForCurrentImage()
        let alertController = UIAlertController(title: "Galactic Restoration Achievement Status", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    private func galacticRestorationCheckConditionForCurrentImage() -> Bool {
        switch galacticRestorationCurrentImageIndex {
        case 0:
            return galacticRestorationGlobalScore >= 100
        case 1:
            return galacticRestorationGlobalScore >= 250
        case 2:
            return galacticRestorationGlobalScore >= 1000
        default:
            return false
        }
    }
    
    private func galacticRestorationAchievementMessageForCurrentImage() -> String {
        switch galacticRestorationCurrentImageIndex {
        case 0:
            return galacticRestorationGlobalScore >= 100 ?
            "Achievement completed! 100 Galactic points collected!" :
            "Achievement not completed. Collect 100 Galactic points!"
        case 1:
            return galacticRestorationGlobalScore >= 250 ?
            "Achievement completed! 250 Galactic points collected!" :
            "Achievement not completed. Collect 250 Galactic points!"
        case 2:
            return galacticRestorationGlobalScore >= 1000 ?
            "Achievement completed! 1000 Galactic points collected!" :
            "Achievement not completed. Collect 1000 Galactic points!"
        default:
            return ""
        }
    }
}
