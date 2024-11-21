import UIKit
import SnapKit

class GalacticRestorationLoadingViewController: UIViewController {

    // MARK: - Properties
    private let galacticRestorationBackgroundView = UIImageView()
    private let galacticRestorationLavaPlanetImageView = UIImageView()
    private let galacticRestorationLoadingImageView = UIImageView()
    
    private var galacticRestorationLoadingTimer: Timer?
    private var galacticRestorationJumpTimer: Timer?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        galacticRestorationInitializeUI()
        galacticRestorationSetConstraints()
        
        galacticRestorationStartJumpAnimation()
        galacticRestorationStartLoadingAnimation()
        galacticRestorationPresentNextController()
    }
    
    deinit {
        galacticRestorationStopTimers()
    }
    
    // MARK: - UI Setup
    private func galacticRestorationInitializeUI() {
        galacticRestorationSetupBackground()
        galacticRestorationSetupLavaPlanet()
        galacticRestorationSetupLoadingIndicator()
    }
    
    private func galacticRestorationSetupBackground() {
        galacticRestorationBackgroundView.image = UIImage(named: "Background")
        galacticRestorationBackgroundView.contentMode = .scaleAspectFill
        view.addSubview(galacticRestorationBackgroundView)
    }
    
    private func galacticRestorationSetupLavaPlanet() {
        galacticRestorationLavaPlanetImageView.image = UIImage(named: "LavaPlanet")
        galacticRestorationLavaPlanetImageView.contentMode = .scaleAspectFit
        view.addSubview(galacticRestorationLavaPlanetImageView)
    }
    
    private func galacticRestorationSetupLoadingIndicator() {
        galacticRestorationLoadingImageView.image = UIImage(named: "LoadingImg1")
        galacticRestorationLoadingImageView.contentMode = .scaleAspectFill
        view.addSubview(galacticRestorationLoadingImageView)
    }
    
    // MARK: - Constraints
    private func galacticRestorationSetConstraints() {
        galacticRestorationBackgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        galacticRestorationLavaPlanetImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-50)
            make.width.height.equalTo(150)
        }
        
        galacticRestorationLoadingImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(galacticRestorationLavaPlanetImageView.snp.bottom).offset(30)
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
    }
    
    // MARK: - Animations
    private func galacticRestorationStartJumpAnimation() {
        galacticRestorationJumpTimer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(galacticRestorationPerformJumpAnimation), userInfo: nil, repeats: true)
    }
    
    @objc private func galacticRestorationPerformJumpAnimation() {
        UIView.animate(withDuration: 0.2) {
            self.galacticRestorationLavaPlanetImageView.transform = CGAffineTransform(translationX: 0, y: -100)
        } completion: { _ in
            UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseIn) {
                self.galacticRestorationLavaPlanetImageView.transform = .identity
            }
        }
    }
    
    private func galacticRestorationStartLoadingAnimation() {
        var galacticRestorationImageIndex = 1
        galacticRestorationLoadingTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            galacticRestorationImageIndex = (galacticRestorationImageIndex % 3) + 1
            self.galacticRestorationLoadingImageView.image = UIImage(named: "LoadingImg\(galacticRestorationImageIndex)")
        }
    }
    
    // MARK: - Navigation
    private func galacticRestorationNavigateAfterDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.galacticRestorationPresentNextController()
        }
    }
    
    private func galacticRestorationPresentNextController() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            guard let self = self else { return }
            let galacticLaunched = UserDefaults.standard.bool(forKey: "galactic")
            if !galacticLaunched {
                UserDefaults.standard.set(true, forKey: "galactic")
                UserDefaults.standard.synchronize()
                let galacticNextViewController = GalacticRestorationWelcomeViewController()
                galacticNextViewController.modalPresentationStyle = .fullScreen
                self.present(galacticNextViewController, animated: true, completion: nil)
            } else {
                let galacticNextViewController = GalacticRestorationMainMenuViewController()
                galacticNextViewController.modalPresentationStyle = .fullScreen
                self.present(galacticNextViewController, animated: true, completion: nil)
            }
        }
    }
    
    // MARK: - Timer Management
    private func galacticRestorationStopTimers() {
        galacticRestorationLoadingTimer?.invalidate()
        galacticRestorationJumpTimer?.invalidate()
    }
}
