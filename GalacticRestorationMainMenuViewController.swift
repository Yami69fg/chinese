import UIKit
import SnapKit

class GalacticRestorationMainMenuViewController: UIViewController {
    
    private var galacticRestorationGlobalScore: Int {
        get { UserDefaults.standard.integer(forKey: "galacticRestorationScore") }
        set { UserDefaults.standard.set(newValue, forKey: "galacticRestorationScore") }
    }
    
    private var galacticRestorationBackgroundView = UIImageView()
    private var galacticRestorationImageView = UIImageView()
    private var galacticRestorationStartButton = UIButton()
    private var galacticRestorationStoreButton = UIButton()
    private var galacticRestorationAchievementsButton = UIButton()
    private var galacticRestorationTimerButton = UIButton()
    private var galacticRestorationTimerLabel = UILabel()
    private var galacticRestorationRulesButton = UIButton()
    private var galacticRestorationLoreButton = UIButton()
    
    private let galacticRestorationTimerKey: String = "galacticRestorationTimer"
    private let galacticRestorationTimerDuration: TimeInterval = 3600
    private var galacticRestorationTimer: Timer?
    private var galacticRestorationRemainingTime: TimeInterval = 3600
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGalacticRestorationUI()
        setupGalacticRestorationActions()
        loadSavedGalacticRestorationTimerState()
        startGalacticRestorationTimer()
        galacticRestorationConfigureTimerLabel()
        galacticRestorationTimerButton.isEnabled = false
    }
    
    private func setupGalacticRestorationUI() {
        galacticRestorationSetupBackgroundView()
        galacticRestorationSetupTimerButton()
        galacticRestorationSetupImageView()
        galacticRestorationSetupStartButton()
        galacticRestorationSetupAchievementsButton()
        galacticRestorationSetupStoreButton()
        galacticRestorationSetupTimerLabel()
        galacticRestorationSetupRulesButton()
        galacticRestorationSetupLoreButton()
    }
    
    private func galacticRestorationSetupBackgroundView() {
        galacticRestorationBackgroundView.image = UIImage(named: "Background")
        galacticRestorationBackgroundView.contentMode = .scaleAspectFill
        view.addSubview(galacticRestorationBackgroundView)
        galacticRestorationBackgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func galacticRestorationSetupImageView() {
        galacticRestorationImageView.image = UIImage(named: "LavaPlanet")
        galacticRestorationImageView.contentMode = .scaleAspectFit
        view.addSubview(galacticRestorationImageView)
        galacticRestorationImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(galacticRestorationTimerButton.snp.bottom).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(200)
        }
    }
    
    private func galacticRestorationSetupStartButton() {
        galacticRestorationStartButton.setImage(UIImage(named: "History"), for: .normal)
        view.addSubview(galacticRestorationStartButton)
        galacticRestorationStartButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(galacticRestorationImageView.snp.bottom).offset(30)
            make.width.equalTo(200)
            make.height.equalTo(100)
        }
    }
    
    private func galacticRestorationSetupStoreButton() {
        galacticRestorationStoreButton.setImage(UIImage(named: "Store"), for: .normal)
        view.addSubview(galacticRestorationStoreButton)
        galacticRestorationStoreButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(75)
            make.leading.equalToSuperview().inset(20)
            make.width.height.equalTo(60)
        }
    }
    
    private func galacticRestorationSetupAchievementsButton() {
        galacticRestorationAchievementsButton.setImage(UIImage(named: "Acieve"), for: .normal)
        view.addSubview(galacticRestorationAchievementsButton)
        galacticRestorationAchievementsButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(75)
            make.trailing.equalToSuperview().inset(20)
            make.width.height.equalTo(60)
        }
    }
    
    private func galacticRestorationSetupTimerButton() {
        galacticRestorationTimerButton.setImage(UIImage(named: "Score"), for: .normal)
        view.addSubview(galacticRestorationTimerButton)
        galacticRestorationTimerButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(75)
            make.centerX.equalToSuperview()
            make.width.equalTo(175)
            make.height.equalTo(50)
        }
    }
    
    private func galacticRestorationSetupTimerLabel() {
        galacticRestorationTimerLabel.font = UIFont(name: "Caprasimo", size: 20)
        galacticRestorationTimerLabel.textColor = .white
        galacticRestorationTimerLabel.textAlignment = .center
        view.addSubview(galacticRestorationTimerLabel)
        galacticRestorationTimerLabel.snp.makeConstraints { make in
            make.center.equalTo(galacticRestorationTimerButton)
        }
    }
    
    private func galacticRestorationSetupRulesButton() {
        galacticRestorationRulesButton.setImage(UIImage(named: "Play"), for: .normal)
        view.addSubview(galacticRestorationRulesButton)
        galacticRestorationRulesButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(galacticRestorationStartButton.snp.bottom).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
    }
    
    private func galacticRestorationSetupLoreButton() {
        galacticRestorationLoreButton.setImage(UIImage(named: "Guide"), for: .normal)
        view.addSubview(galacticRestorationLoreButton)
        galacticRestorationLoreButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(galacticRestorationRulesButton.snp.bottom).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
    }
    
    private func setupGalacticRestorationActions() {
        galacticRestorationStartButton.addTarget(self, action: #selector(tapGalacticRestorationLoreButton), for: .touchUpInside)
        addGalacticSound(button: galacticRestorationStartButton)
        galacticRestorationStoreButton.addTarget(self, action: #selector( tapGalacticRestorationStoreButton), for: .touchUpInside)
        addGalacticSound(button: galacticRestorationStoreButton)
        galacticRestorationAchievementsButton.addTarget(self, action: #selector(tapGalacticRestorationAchievementsButton), for: .touchUpInside)
        addGalacticSound(button: galacticRestorationAchievementsButton)
        galacticRestorationTimerButton.addTarget(self, action: #selector(galacticRestorationRewardButtonTapped), for: .touchUpInside)
        addGalacticSound(button: galacticRestorationTimerButton)
        galacticRestorationRulesButton.addTarget(self, action: #selector(tapGalacticRestorationStartButton), for: .touchUpInside)
        addGalacticSound(button: galacticRestorationRulesButton)
        galacticRestorationLoreButton.addTarget(self, action: #selector(tapGalacticRestorationRulesButton), for: .touchUpInside)
        addGalacticSound(button: galacticRestorationLoreButton)
    }
    
    @objc private func tapGalacticRestorationStartButton() {
        let galacticNextViewController = GalacticRestorationGamesViewController()
        galacticNextViewController.modalPresentationStyle = .fullScreen
        self.present(galacticNextViewController, animated: true, completion: nil)
    }
    
    @objc private func tapGalacticRestorationStoreButton() {
        let galacticNextViewController = GalacticRestorationStoreViewController()
        galacticNextViewController.modalPresentationStyle = .fullScreen
        self.present(galacticNextViewController, animated: true, completion: nil)
    }
    
    @objc private func tapGalacticRestorationAchievementsButton() {
        let galacticNextViewController = GalacticRestorationAcieveViewController()
        galacticNextViewController.modalPresentationStyle = .fullScreen
        self.present(galacticNextViewController, animated: true, completion: nil)
    }
    
    @objc private func tapGalacticRestorationRulesButton() {
        let galacticNextViewController = GalacticRestorationGuideViewController()
        galacticNextViewController.modalPresentationStyle = .fullScreen
        self.present(galacticNextViewController, animated: true, completion: nil)
    }
    
    @objc private func tapGalacticRestorationLoreButton() {
        let galacticNextViewController = ChineseHistory()
        galacticNextViewController.modalPresentationStyle = .fullScreen
        self.present(galacticNextViewController, animated: true, completion: nil)
    }
    
    private func startGalacticRestorationTimer() {
        galacticRestorationTimer?.invalidate()
        galacticRestorationTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateGalacticRestorationTimer), userInfo: nil, repeats: true)
    }
    
    @objc private func updateGalacticRestorationTimer() {
        if galacticRestorationRemainingTime > 0 {
            galacticRestorationRemainingTime -= 1
            galacticRestorationTimerLabel.text = formatGalacticRestorationTime(galacticRestorationRemainingTime)
            saveGalacticRestorationTimerState()
        } else {
            galacticRestorationTimer?.invalidate()
            galacticRestorationTimerLabel.text = "00:00:00"
            unlockGalacticRestorationRewardButton()
        }
    }
    
    private func formatGalacticRestorationTime(_ time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = (Int(time) % 3600) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    private func unlockGalacticRestorationRewardButton() {
        galacticRestorationTimerButton.isEnabled = true
    }
    
    private func loadSavedGalacticRestorationTimerState() {
        let timerStartTime = UserDefaults.standard.double(forKey: galacticRestorationTimerKey)
        if timerStartTime == 0 {
            galacticRestorationRemainingTime = galacticRestorationTimerDuration
            UserDefaults.standard.set(Date().timeIntervalSince1970, forKey: galacticRestorationTimerKey)
        } else {
            let elapsedTime = Date().timeIntervalSince1970 - timerStartTime
            galacticRestorationRemainingTime = max(0, galacticRestorationTimerDuration - elapsedTime)
        }
        galacticRestorationTimerLabel.text = formatGalacticRestorationTime(galacticRestorationRemainingTime)
    }
    
    private func saveGalacticRestorationTimerState() {
        UserDefaults.standard.set(galacticRestorationRemainingTime, forKey: "remainingGalacticRestorationTime")
    }
    
    @objc private func galacticRestorationRewardButtonTapped() {
        galacticRestorationRemainingTime = galacticRestorationTimerDuration
        galacticRestorationGlobalScore += 50
        galacticRestorationTimerLabel.text = formatGalacticRestorationTime(galacticRestorationRemainingTime)
        galacticRestorationTimerButton.isEnabled = false
        UserDefaults.standard.set(Date().timeIntervalSince1970, forKey: galacticRestorationTimerKey)
        startGalacticRestorationTimer()
    }
    
    private func galacticRestorationConfigureTimerLabel() {
        galacticRestorationTimerLabel.text = formatGalacticRestorationTime(galacticRestorationRemainingTime)
        galacticRestorationTimerButton.addSubview(galacticRestorationTimerLabel)
        galacticRestorationTimerLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

}
