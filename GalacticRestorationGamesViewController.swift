import UIKit
import SnapKit

class GalacticRestorationGamesViewController: UIViewController {
    
    private var galacticRestorationBackdropImageView = UIImageView()
    private var galacticRestorationCenterImageView = UIImageView()
    private var galacticRestorationLeftButton = UIButton()
    private var galacticRestorationRightButton = UIButton()
    private var galacticRestorationCloseButton = UIButton()
    private var galacticRestorationPlayButton = UIButton()
    private var galacticRestorationScoreBackgroundImageView = UIImageView()
    private var galacticRestorationScoreLabel = UILabel()
    
    private let galacticRestorationImageNames = ["Game1", "Game2"]
    private var galacticRestorationCurrentImageIndex = 0
    
    private var galacticRestorationGlobalScore: Int {
        get { UserDefaults.standard.integer(forKey: "galacticRestorationScore") }
        set { UserDefaults.standard.set(newValue, forKey: "galacticRestorationScore") }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        galacticRestorationScoreLabel.text = "\(galacticRestorationGlobalScore)"
        
        galacticRestorationSetupBackdropImageView()
        galacticRestorationSetupCenterImageView()
        galacticRestorationSetupScoreBackgroundImageView()
        galacticRestorationSetupScoreLabel()
        galacticRestorationSetupCloseButton()
        galacticRestorationSetupLeftButton()
        galacticRestorationSetupRightButton()
        galacticRestorationSetupPlayButton()
        
        updateGalacticRestorationCenterImage()
        setupGalacticRestorationActions()
    }
    
    private func galacticRestorationSetupBackdropImageView() {
        galacticRestorationBackdropImageView.image = UIImage(named: "Background")
        galacticRestorationBackdropImageView.contentMode = .scaleAspectFill
        view.addSubview(galacticRestorationBackdropImageView)
        
        galacticRestorationBackdropImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func galacticRestorationSetupCenterImageView() {
        galacticRestorationCenterImageView.contentMode = .scaleAspectFit
        view.addSubview(galacticRestorationCenterImageView)
        
        galacticRestorationCenterImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(galacticRestorationCenterImageView.snp.width)
        }
    }
    
    private func galacticRestorationSetupScoreBackgroundImageView() {
        galacticRestorationScoreBackgroundImageView.image = UIImage(named: "Score")
        galacticRestorationScoreBackgroundImageView.contentMode = .scaleAspectFit
        view.addSubview(galacticRestorationScoreBackgroundImageView)
        
        galacticRestorationScoreBackgroundImageView.snp.makeConstraints { make in
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
        galacticRestorationScoreBackgroundImageView.addSubview(galacticRestorationScoreLabel)
        
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
    
    private func galacticRestorationSetupPlayButton() {
        galacticRestorationPlayButton.setImage(UIImage(named: "Play"), for: .normal)
        galacticRestorationPlayButton.contentMode = .scaleAspectFit
        galacticRestorationPlayButton.layer.cornerRadius = 10
        galacticRestorationPlayButton.clipsToBounds = true
        view.addSubview(galacticRestorationPlayButton)
        
        galacticRestorationPlayButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(galacticRestorationCenterImageView.snp.bottom).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
    }
    
    private func updateGalacticRestorationCenterImage() {
        galacticRestorationCenterImageView.image = UIImage(named: galacticRestorationImageNames[galacticRestorationCurrentImageIndex])
    }
    
    private func setupGalacticRestorationActions() {
        galacticRestorationLeftButton.addTarget(self, action: #selector(galacticRestorationLeftButtonTapped), for: .touchUpInside)
        addGalacticSound(button: galacticRestorationLeftButton)
        galacticRestorationRightButton.addTarget(self, action: #selector(galacticRestorationRightButtonTapped), for: .touchUpInside)
        addGalacticSound(button: galacticRestorationRightButton)
        galacticRestorationCloseButton.addTarget(self, action: #selector(galacticRestorationCloseButtonTapped), for: .touchUpInside)
        addGalacticSound(button: galacticRestorationCloseButton)
        galacticRestorationPlayButton.addTarget(self, action: #selector(galacticRestorationPlayButtonTapped), for: .touchUpInside)
        addGalacticSound(button: galacticRestorationPlayButton)
    }
    
    @objc private func galacticRestorationLeftButtonTapped() {
        if galacticRestorationCurrentImageIndex > 0 {
            galacticRestorationCurrentImageIndex -= 1
            updateGalacticRestorationCenterImage()
        }
    }
    
    @objc private func galacticRestorationRightButtonTapped() {
        if galacticRestorationCurrentImageIndex < galacticRestorationImageNames.count - 1 {
            galacticRestorationCurrentImageIndex += 1
            updateGalacticRestorationCenterImage()
        }
    }
    
    @objc private func galacticRestorationCloseButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func galacticRestorationPlayButtonTapped() {
        let galacticNextViewController = GalacticRestorationDifficultViewController()
        galacticNextViewController.galacticRestorationCurrentImageIndex = galacticRestorationCurrentImageIndex
        galacticNextViewController.modalPresentationStyle = .fullScreen
        self.present(galacticNextViewController, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        galacticRestorationScoreLabel.text = "\(galacticRestorationGlobalScore)"
    }
}
