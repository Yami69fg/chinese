import UIKit
import SnapKit

class GalacticRestorationControllSoundViewController: UIViewController {
    
    private var galacticRestorationControlPanelBackgroundDetails = UIImageView()
    private var galacticRestorationControlPanelSettingsHeaderLabel = UIImageView()
    private var galacticRestorationSoundTitleLabel = UILabel()
    private var galacticRestorationVibrationTitleLabel = UILabel()
    private var galacticRestorationSoundToggleSwitchButton = UIButton()
    private var galacticRestorationVibrationToggleSwitchButton = UIButton()
    private var galacticRestorationMainMenuButton = UIButton()
    private var galacticRestorationReturnToGameplayButton = UIButton()

    var galacticRestorationOnReturnToMenu: (() -> ())?
    var galacticRestorationResume: (() -> ())?

    override func viewDidLoad() {
        super.viewDidLoad()
        galacticRestorationSetupSubviewsAndConstraints()
        galacticRestorationConfigureButtonActions()
        galacticRestorationSetupDefaultSettings()
        galacticRestorationLoadToggleButtonStates()
    }
    
    private func galacticRestorationSetupSubviewsAndConstraints() {
        galacticRestorationSetupControlPanelBackgroundDetails()
        galacticRestorationSetupControlPanelSettingsHeaderLabel()
        galacticRestorationSetupSoundTitleLabel()
        galacticRestorationSetupVibrationTitleLabel()
        galacticRestorationSetupSoundToggleSwitchButton()
        galacticRestorationSetupVibrationToggleSwitchButton()
        galacticRestorationSetupMainMenuButton()
        galacticRestorationSetupReturnToGameplayButton()

    }

    
    private func galacticRestorationSetupControlPanelBackgroundDetails() {
        galacticRestorationControlPanelBackgroundDetails.image = UIImage(named: "Rectangle")
        galacticRestorationControlPanelBackgroundDetails.contentMode = .scaleToFill
        view.addSubview(galacticRestorationControlPanelBackgroundDetails)
        galacticRestorationControlPanelBackgroundDetails.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.height.equalToSuperview().multipliedBy(0.3)
        }
    }

    private func galacticRestorationSetupControlPanelSettingsHeaderLabel() {
        galacticRestorationControlPanelSettingsHeaderLabel.image = UIImage(named: "SettingImg")
        galacticRestorationControlPanelSettingsHeaderLabel.contentMode = .scaleToFill
        view.addSubview(galacticRestorationControlPanelSettingsHeaderLabel)
        galacticRestorationControlPanelSettingsHeaderLabel.snp.makeConstraints {
            $0.bottom.equalTo(galacticRestorationControlPanelBackgroundDetails.snp.top)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.7)
            $0.height.equalTo(100)
        }
    }

    // Setup for Labels
    private func galacticRestorationSetupSoundTitleLabel() {
        galacticRestorationSoundTitleLabel.text = "Sound"
        galacticRestorationSoundTitleLabel.font = UIFont(name: "Caprasimo", size: 32)
        galacticRestorationSoundTitleLabel.textColor = .white
        galacticRestorationSoundTitleLabel.textAlignment = .center
        view.addSubview(galacticRestorationSoundTitleLabel)
        galacticRestorationSoundTitleLabel.snp.makeConstraints {
            $0.left.equalTo(galacticRestorationControlPanelBackgroundDetails.snp.left).offset(20)
            $0.centerY.equalToSuperview().offset(-30)
        }
    }

    private func galacticRestorationSetupVibrationTitleLabel() {
        galacticRestorationVibrationTitleLabel.text = "Vibration"
        galacticRestorationVibrationTitleLabel.font = UIFont(name: "Caprasimo", size: 32)
        galacticRestorationVibrationTitleLabel.textColor = .white
        galacticRestorationVibrationTitleLabel.textAlignment = .center
        view.addSubview(galacticRestorationVibrationTitleLabel)
        galacticRestorationVibrationTitleLabel.snp.makeConstraints {
            $0.left.equalTo(galacticRestorationControlPanelBackgroundDetails.snp.left).offset(30)
            $0.centerY.equalToSuperview().offset(30)
        }
    }

    // Setup for Buttons
    private func galacticRestorationSetupSoundToggleSwitchButton() {
        view.addSubview(galacticRestorationSoundToggleSwitchButton)
        galacticRestorationSoundToggleSwitchButton.snp.makeConstraints {
            $0.left.equalTo(galacticRestorationSoundTitleLabel.snp.right).offset(20)
            $0.centerY.equalToSuperview().offset(-30)
            $0.width.equalTo(60)
            $0.height.equalTo(35)
        }
    }

    private func galacticRestorationSetupVibrationToggleSwitchButton() {
        view.addSubview(galacticRestorationVibrationToggleSwitchButton)
        galacticRestorationVibrationToggleSwitchButton.snp.makeConstraints {
            $0.left.equalTo(galacticRestorationVibrationTitleLabel.snp.right).offset(20)
            $0.centerY.equalToSuperview().offset(30)
            $0.width.equalTo(60)
            $0.height.equalTo(35)
        }
    }

    private func galacticRestorationSetupMainMenuButton() {
        galacticRestorationMainMenuButton.setImage(UIImage(named: "Menu"), for: .normal)
        view.addSubview(galacticRestorationMainMenuButton)
        galacticRestorationMainMenuButton.snp.makeConstraints {
            $0.top.equalTo(galacticRestorationControlPanelBackgroundDetails.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(50)
            $0.width.equalTo(135)
            $0.height.equalTo(60)
        }
    }

    private func galacticRestorationSetupReturnToGameplayButton() {
        galacticRestorationReturnToGameplayButton.setImage(UIImage(named: "Back"), for: .normal)
        view.addSubview(galacticRestorationReturnToGameplayButton)
        galacticRestorationReturnToGameplayButton.snp.makeConstraints {
            $0.top.equalTo(galacticRestorationControlPanelBackgroundDetails.snp.bottom).offset(10)
            $0.trailing.equalToSuperview().offset(-50)
            $0.width.equalTo(135)
            $0.height.equalTo(60)
        }
    }

    private func galacticRestorationSetupDefaultSettings() {
        if UserDefaults.standard.object(forKey: "sound") == nil {
            UserDefaults.standard.set(true, forKey: "sound")
        }
        if UserDefaults.standard.object(forKey: "vibro") == nil {
            UserDefaults.standard.set(true, forKey: "vibro")
        }
    }

    private func galacticRestorationLoadToggleButtonStates() {
        let soundOn = UserDefaults.standard.bool(forKey: "sound")
        let vibrationOn = UserDefaults.standard.bool(forKey: "vibro")
        
        galacticRestorationSoundToggleSwitchButton.setImage(UIImage(named: soundOn ? "On" : "Off"), for: .normal)
        galacticRestorationVibrationToggleSwitchButton.setImage(UIImage(named: vibrationOn ? "On" : "Off"), for: .normal)
    }

    private func galacticRestorationConfigureButtonActions() {
        galacticRestorationMainMenuButton.addTarget(self, action: #selector(galacticRestorationMainMenuTapped), for: .touchUpInside)
        
        galacticRestorationReturnToGameplayButton.addTarget(self, action: #selector(galacticRestorationReturnToGameplayTapped), for: .touchUpInside)
        
        galacticRestorationSoundToggleSwitchButton.addTarget(self, action: #selector(galacticRestorationToggleSound), for: .touchUpInside)
        
        galacticRestorationVibrationToggleSwitchButton.addTarget(self, action: #selector(galacticRestorationToggleVibration), for: .touchUpInside)
        
        addGalacticSound(button: galacticRestorationMainMenuButton)
        addGalacticSound(button: galacticRestorationReturnToGameplayButton)
        addGalacticSound(button: galacticRestorationSoundToggleSwitchButton)
        addGalacticSound(button: galacticRestorationVibrationToggleSwitchButton)
    }

    // Button Action Methods
    @objc private func galacticRestorationToggleSound() {
        let soundOn = galacticRestorationSoundToggleSwitchButton.currentImage == UIImage(named: "On")
        let newSoundOn = !soundOn
        galacticRestorationSoundToggleSwitchButton.setImage(UIImage(named: newSoundOn ? "On" : "Off"), for: .normal)
        UserDefaults.standard.set(newSoundOn, forKey: "sound")
    }

    @objc private func galacticRestorationToggleVibration() {
        let vibrationOn = galacticRestorationVibrationToggleSwitchButton.currentImage == UIImage(named: "On")
        let newVibrationOn = !vibrationOn
        galacticRestorationVibrationToggleSwitchButton.setImage(UIImage(named: newVibrationOn ? "On" : "Off"), for: .normal)
        UserDefaults.standard.set(newVibrationOn, forKey: "vibro")
    }

    @objc private func galacticRestorationMainMenuTapped() {
        dismiss(animated: false)
        galacticRestorationOnReturnToMenu?()
    }

    @objc private func galacticRestorationReturnToGameplayTapped() {
        galacticRestorationResume?()
        dismiss(animated: true)
    }

}
