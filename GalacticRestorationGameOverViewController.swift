import UIKit
import SnapKit

class GalacticRestorationGameOverViewController: UIViewController {
    
    private var galacticRestorationBackgroundDetailsImageView: UIImageView!
    private var galacticRestorationSettingsHeaderImageView: UIImageView!
    private var galacticRestorationScoreTitleLabel: UILabel!
    private var galacticRestorationTotalScoreTitleLabel: UILabel!
    private var galacticRestorationMainMenuButton: UIButton!
    private var galacticRestorationRetryButton: UIButton!
    
    var galacticRestorationOnReturnToMenu: (() -> ())?
    var galacticRestorationOnRestart: (() -> ())?
    
    var galacticRestorationScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureGalacticRestorationInterface()
        updateGalacticRestorationContent()
        overGalacticSound()
    }
    
    private func configureGalacticRestorationInterface() {
        galacticRestorationSetupBackgroundDetailsImageView()
        galacticRestorationSetupSettingsHeaderImageView()
        galacticRestorationSetupScoreTitleLabel()
        galacticRestorationSetupTotalScoreTitleLabel()
        galacticRestorationSetupMainMenuButton()
        galacticRestorationSetupRetryButton()
        setupGalacticRestorationActions()
        setupGalacticRestorationConstraints()
    }

    private func galacticRestorationSetupBackgroundDetailsImageView() {
        galacticRestorationBackgroundDetailsImageView = UIImageView()
        galacticRestorationBackgroundDetailsImageView.image = UIImage(named: "Rectangle")
        galacticRestorationBackgroundDetailsImageView.contentMode = .scaleToFill
        view.addSubview(galacticRestorationBackgroundDetailsImageView)
    }
    
    private func galacticRestorationSetupSettingsHeaderImageView() {
        galacticRestorationSettingsHeaderImageView = UIImageView()
        galacticRestorationSettingsHeaderImageView.image = UIImage(named: "WinImg")
        galacticRestorationSettingsHeaderImageView.contentMode = .scaleAspectFit
        view.addSubview(galacticRestorationSettingsHeaderImageView)
    }
    
    private func galacticRestorationSetupScoreTitleLabel() {
        galacticRestorationScoreTitleLabel = UILabel()
        galacticRestorationScoreTitleLabel.text = "Score"
        galacticRestorationScoreTitleLabel.font = UIFont(name: "Caprasimo", size: 30)
        galacticRestorationScoreTitleLabel.textColor = .white
        galacticRestorationScoreTitleLabel.textAlignment = .center
        view.addSubview(galacticRestorationScoreTitleLabel)
    }
    
    private func galacticRestorationSetupTotalScoreTitleLabel() {
        galacticRestorationTotalScoreTitleLabel = UILabel()
        galacticRestorationTotalScoreTitleLabel.text = "Total score"
        galacticRestorationTotalScoreTitleLabel.font = UIFont(name: "Caprasimo", size: 30)
        galacticRestorationTotalScoreTitleLabel.textColor = .white
        galacticRestorationTotalScoreTitleLabel.textAlignment = .center
        view.addSubview(galacticRestorationTotalScoreTitleLabel)
    }
    
    private func galacticRestorationSetupMainMenuButton() {
        galacticRestorationMainMenuButton = UIButton()
        galacticRestorationMainMenuButton.setImage(UIImage(named: "Menu"), for: .normal)
        view.addSubview(galacticRestorationMainMenuButton)
    }
    
    private func galacticRestorationSetupRetryButton() {
        galacticRestorationRetryButton = UIButton()
        galacticRestorationRetryButton.setImage(UIImage(named: "Again"), for: .normal)
        view.addSubview(galacticRestorationRetryButton)
    }
    
    private func setupGalacticRestorationActions() {
        galacticRestorationMainMenuButton.addTarget(self, action: #selector(galacticRestorationNavigateToMainMenu), for: .touchUpInside)
        addGalacticSound(button: galacticRestorationMainMenuButton)
        galacticRestorationRetryButton.addTarget(self, action: #selector(galacticRestorationRestartGameSession), for: .touchUpInside)
        addGalacticSound(button: galacticRestorationRetryButton)
    }
    
    private func setupGalacticRestorationConstraints() {
        
        galacticRestorationBackgroundDetailsImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalToSuperview().multipliedBy(0.25)
        }

        galacticRestorationSettingsHeaderImageView.snp.makeConstraints { make in
            make.bottom.equalTo(galacticRestorationBackgroundDetailsImageView.snp.top).offset(-30)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(200)
        }

        galacticRestorationScoreTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(galacticRestorationBackgroundDetailsImageView.snp.left).offset(20)
            make.centerY.equalToSuperview().offset(-30)
        }

        galacticRestorationTotalScoreTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(galacticRestorationBackgroundDetailsImageView.snp.left).offset(20)
            make.centerY.equalToSuperview().offset(30)
        }

        galacticRestorationMainMenuButton.snp.makeConstraints { make in
            make.top.equalTo(galacticRestorationBackgroundDetailsImageView.snp.bottom).offset(10)
            make.left.equalTo(galacticRestorationBackgroundDetailsImageView.snp.left)
            make.width.equalTo(135)
            make.height.equalTo(60)
        }

        galacticRestorationRetryButton.snp.makeConstraints { make in
            make.top.equalTo(galacticRestorationBackgroundDetailsImageView.snp.bottom).offset(10)
            make.right.equalTo(galacticRestorationBackgroundDetailsImageView.snp.right)
            make.width.equalTo(135)
            make.height.equalTo(60)
        }
    }
    
    private func updateGalacticRestorationContent() {
        if galacticRestorationScore<50 {
            galacticRestorationSettingsHeaderImageView.image = UIImage(named: "LoseImg")
        }
        
        galacticRestorationScoreTitleLabel.text = "Score \(galacticRestorationScore)"
        galacticRestorationTotalScoreTitleLabel.text = "Total score \(UserDefaults.standard.integer(forKey: "galacticRestorationScore"))"
    }
    
    @objc private func galacticRestorationNavigateToMainMenu() {
        dismiss(animated: false)
        galacticRestorationOnReturnToMenu?()
    }
    
    @objc private func galacticRestorationRestartGameSession() {
        dismiss(animated: true)
        galacticRestorationOnRestart?()
    }
}

