import UIKit
import SnapKit

class GalacticRestorationStoreViewController: UIViewController {

    private var galacticRestorationBackdropImageView = UIImageView()
    private var galacticRestorationCenterImageView = UIImageView()
    private var galacticRestorationLeftButton = UIButton()
    private var galacticRestorationRightButton = UIButton()
    private var galacticRestorationCloseButton = UIButton()
    private var galacticRestorationBuyButton = UIButton()
    private var galacticRestorationScoreBackgroundImageView = UIImageView()
    private var galacticRestorationScoreLabel = UILabel()

    private var galacticRestorationPreviewImageNames = ["BuyButton1", "BuyButton2", "BuyButton3"]
    private var galacticRestorationBackgroundImageNames = ["Background1", "Background2", "Background3"]
    private var galacticRestorationCurrentImageIndex = 0

    private var galacticRestorationSelectedImageName: String {
        get {
            return UserDefaults.standard.string(forKey: "galacticRestorationSelectedImageName") ?? "GalacticRestoration"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "galacticRestorationSelectedImageName")
        }
    }

    private var galacticRestorationGlobalScore: Int {
        get { UserDefaults.standard.integer(forKey: "galacticRestorationScore") }
        set { UserDefaults.standard.set(newValue, forKey: "galacticRestorationScore") }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        galacticRestorationScoreLabel.text = "\(galacticRestorationGlobalScore)"
        galacticRestorationSetupBackgroundView()
        galacticRestorationSetupCenterImageView()
        galacticRestorationSetupScoreBackgroundView()
        galacticRestorationSetupCloseButton()
        galacticRestorationSetupLeftButton()
        galacticRestorationSetupRightButton()
        galacticRestorationSetupBuyButton()
        galacticRestorationSetupScoreLabel()
        galacticRestorationSetupActions()
        galacticRestorationUpdateCenterImage()
    }

    private func galacticRestorationSetupBackgroundView() {
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

    private func galacticRestorationSetupScoreBackgroundView() {
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

    private func galacticRestorationSetupBuyButton() {
        galacticRestorationBuyButton.setImage(UIImage(named: "Buy"), for: .normal)
        galacticRestorationBuyButton.contentMode = .scaleAspectFit
        galacticRestorationBuyButton.layer.cornerRadius = 10
        galacticRestorationBuyButton.clipsToBounds = true
        view.addSubview(galacticRestorationBuyButton)
        galacticRestorationBuyButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(galacticRestorationCenterImageView.snp.bottom).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
    }

    private func galacticRestorationUpdateCenterImage() {
        galacticRestorationCenterImageView.image = UIImage(named: galacticRestorationPreviewImageNames[galacticRestorationCurrentImageIndex])?.withRenderingMode(.alwaysOriginal)
    }

    private func galacticRestorationSetupActions() {
        galacticRestorationLeftButton.addTarget(self, action: #selector(galacticRestorationLeftButtonTapped), for: .touchUpInside)
        addGalacticSound(button: galacticRestorationLeftButton)
        galacticRestorationRightButton.addTarget(self, action: #selector(galacticRestorationRightButtonTapped), for: .touchUpInside)
        addGalacticSound(button: galacticRestorationRightButton)
        galacticRestorationCloseButton.addTarget(self, action: #selector(galacticRestorationCloseButtonTapped), for: .touchUpInside)
        addGalacticSound(button: galacticRestorationCloseButton)
        galacticRestorationBuyButton.addTarget(self, action: #selector(galacticRestorationBuyButtonTapped), for: .touchUpInside)
        addGalacticSound(button: galacticRestorationBuyButton)
    }

    @objc private func galacticRestorationLeftButtonTapped() {
        if galacticRestorationCurrentImageIndex > 0 {
            galacticRestorationCurrentImageIndex -= 1
            galacticRestorationUpdateCenterImage()
        }
    }

    @objc private func galacticRestorationRightButtonTapped() {
        if galacticRestorationCurrentImageIndex < galacticRestorationPreviewImageNames.count - 1 {
            galacticRestorationCurrentImageIndex += 1
            galacticRestorationUpdateCenterImage()
        }
    }

    @objc private func galacticRestorationCloseButtonTapped() {
        dismiss(animated: true, completion: nil)
    }

    @objc private func galacticRestorationBuyButtonTapped() {
        let galacticRestorationCost = galacticRestorationGetCostForCurrentImage()
        let galacticRestorationPurchasedImageName = galacticRestorationBackgroundImageNames[galacticRestorationCurrentImageIndex]
        
        if UserDefaults.standard.bool(forKey: "\(galacticRestorationPurchasedImageName)p") {
            galacticRestorationSetSelectedBackgroundImage(galacticRestorationPurchasedImageName)
            galacticRestorationShowAlert(message: "This image is already purchased and set as the background!")
            return
        }
        
        if galacticRestorationGlobalScore < galacticRestorationCost {
            let galacticRestorationMissingPoints = galacticRestorationCost - galacticRestorationGlobalScore
            galacticRestorationShowAlert(message: "You need \(galacticRestorationMissingPoints) more points to buy this image.")
            return
        }

        galacticRestorationGlobalScore -= galacticRestorationCost
        galacticRestorationScoreLabel.text = "\(galacticRestorationGlobalScore)"
        UserDefaults.standard.set(true, forKey: "\(galacticRestorationPurchasedImageName)p")
        galacticRestorationSetSelectedBackgroundImage(galacticRestorationPurchasedImageName)
        galacticRestorationShowAlert(message: "You've successfully purchased this image!")
    }

    private func galacticRestorationGetCostForCurrentImage() -> Int {
        return (galacticRestorationCurrentImageIndex + 1) * 100
    }

    private func galacticRestorationSetSelectedBackgroundImage(_ imageName: String) {
        galacticRestorationSelectedImageName = imageName
    }

    private func galacticRestorationShowAlert(message: String) {
        let alert = UIAlertController(title: "Galactic Restoration", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
