import UIKit
import SnapKit

class GalacticRestorationWelcomeViewController: UIViewController {
    
    // MARK: - Properties
    private let galacticRestorationBackdropImageView = UIImageView()
    private let galacticRestorationGreetingImageView = UIImageView()
    private let galacticRestorationLavaPlanetButton = UIButton()
    
    private var galacticRestorationTapCount = 0
    
    private let galacticRestorationLavaPlanetImages = [
        "Chest",
    ]
    
    private var galacticRestorationGlobalScore: Int {
        get { UserDefaults.standard.integer(forKey: "galacticRestorationScore") }
        set { UserDefaults.standard.set(newValue, forKey: "galacticRestorationScore") }
    }
    
    private var galacticRestorationCurrentImageIndex = 0

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        galacticRestorationInitializeUI()
        galacticRestorationSetConstraints()
        galacticRestorationSetupActions()
    }
    
    // MARK: - UI Setup
    private func galacticRestorationInitializeUI() {
        galacticRestorationSetupBackdrop()
        galacticRestorationSetupGreetingLabel()
        galacticRestorationSetupLavaPlanetButton()
    }
    
    private func galacticRestorationSetupBackdrop() {
        galacticRestorationBackdropImageView.image = UIImage(named: "Background")
        galacticRestorationBackdropImageView.contentMode = .scaleAspectFill
        view.addSubview(galacticRestorationBackdropImageView)
    }
    
    private func galacticRestorationSetupGreetingLabel() {
        galacticRestorationGreetingImageView.image = UIImage(named: "WelcomeImg")
        galacticRestorationGreetingImageView.contentMode = .scaleAspectFit
        view.addSubview(galacticRestorationGreetingImageView)
    }
    
    private func galacticRestorationSetupLavaPlanetButton() {
        galacticRestorationLavaPlanetButton.setImage(UIImage(named: galacticRestorationLavaPlanetImages[0]), for: .normal)
        galacticRestorationLavaPlanetButton.contentMode = .scaleAspectFit
        galacticRestorationLavaPlanetButton.clipsToBounds = true
        view.addSubview(galacticRestorationLavaPlanetButton)
    }
    
    // MARK: - Constraints
    private func galacticRestorationSetConstraints() {
        galacticRestorationBackdropImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        galacticRestorationGreetingImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(100)
            make.width.equalTo(300)
            make.height.equalTo(100)
        }
        
        galacticRestorationLavaPlanetButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(175)
        }
    }
    
    // MARK: - Actions Setup
    private func galacticRestorationSetupActions() {
        galacticRestorationLavaPlanetButton.addTarget(self, action: #selector(galacticRestorationLavaPlanetTapped), for: .touchUpInside)
        addGalacticSound(button: galacticRestorationLavaPlanetButton)
    }
    
    @objc private func galacticRestorationLavaPlanetTapped() {
        galacticRestorationTapCount += 1
        
        galacticRestorationUpdateLavaPlanetImage()
        galacticRestorationAnimateShakeAndFade()
        
        if galacticRestorationTapCount == 2 {
            galacticRestorationGlobalScore += 50
            galacticRestorationShowGiftAlert()
        }
    }
    
    private func galacticRestorationUpdateLavaPlanetImage() {
        galacticRestorationCurrentImageIndex = (galacticRestorationCurrentImageIndex + 1) % galacticRestorationLavaPlanetImages.count
        galacticRestorationLavaPlanetButton.setImage(UIImage(named: galacticRestorationLavaPlanetImages[galacticRestorationCurrentImageIndex]), for: .normal)
    }
    
    private func galacticRestorationAnimateShakeAndFade() {
        UIView.animate(withDuration: 0.1, animations: {
            self.galacticRestorationLavaPlanetButton.transform = CGAffineTransform(translationX: -10, y: 0)
            self.galacticRestorationLavaPlanetButton.tintColor = .red
            self.galacticRestorationLavaPlanetButton.alpha = 0.8
        }) { _ in
            UIView.animate(withDuration: 0.1, animations: {
                self.galacticRestorationLavaPlanetButton.transform = CGAffineTransform(translationX: 10, y: 0)
            }) { _ in
                UIView.animate(withDuration: 0.1) {
                    self.galacticRestorationLavaPlanetButton.transform = .identity
                    self.galacticRestorationLavaPlanetButton.tintColor = .white
                    self.galacticRestorationLavaPlanetButton.alpha = 1.0
                }
            }
        }
    }
    
    // MARK: - Alert
    private func galacticRestorationShowGiftAlert() {
        let alert = UIAlertController(
            title: "Welcome!",
            message: "You have received \(50) stars!",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            self.galacticRestorationNavigateToMainMenu()
        })
        
        present(alert, animated: true)
    }
    
    // MARK: - Navigation
    private func galacticRestorationNavigateToMainMenu() {
        let galacticNextViewController = GalacticRestorationMainMenuViewController()
        galacticNextViewController.modalPresentationStyle = .fullScreen
        self.present(galacticNextViewController, animated: true, completion: nil)
    }
    
}
