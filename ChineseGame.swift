import UIKit
import SnapKit

class ChineseGame: UIViewController {
    
    var galacticRestorationCentralImageView: UIImageView!
    
    private let galacticRestorationScoreBackgroundImageView = UIImageView()
    private let galacticRestorationGlobalScoreLabel = UILabel()
    private let galacticRestorationPauseButton = UIButton()
    
    private var galacticRestorationGlobalScore: Int {
        get { UserDefaults.standard.integer(forKey: "galacticRestorationScore") }
        set { UserDefaults.standard.set(newValue, forKey: "galacticRestorationScore") }
    }
    
    var galacticRestorationCardImageViews: [UIImageView] = []
    
    let galacticRestorationImages: [UIImage] = [
        UIImage(named: "LavaPlanet")!,
        UIImage(named: "YellowPlanet")!,
        UIImage(named: "BluePlanet")!,
        UIImage(named: "GreenPlanet")!
    ]
    
    let galacticRestorationCardImages: [UIImage] = [
        UIImage(named: "RedPlanetSquare")!,
        UIImage(named: "YellowPlanetSquare")!,
        UIImage(named: "BluePlanetSquare")!,
        UIImage(named: "GreenPlanetSquare")!
    ]
    
    var galacticRestorationCurrentImageIndex: Int!
    var galacticRestorationCandyRotationTimer: Timer?
    var galacticRestorationCardRotationTimers: [Timer] = []
    var galacticRestorationShuffleTimer: Timer?
    var galacticRestorationShuffleInterval: TimeInterval = 1
    var galacticRestorationCorrectSelectionsCount: Int = 0
    
    var galacticRestorationIsGamePaused: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let galacticRestorationBackgroundImageView = UIImageView(image: UIImage(named: UserDefaults.standard.string(forKey: "galacticRestorationSelectedImageName") ?? "GalacticRestoration"))
        galacticRestorationBackgroundImageView.contentMode = .scaleAspectFill
        galacticRestorationBackgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(galacticRestorationBackgroundImageView)
        
        galacticRestorationBackgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        galacticRestorationScoreBackgroundImageView.image = UIImage(named: "Score")
        view.addSubview(galacticRestorationScoreBackgroundImageView)
        galacticRestorationScoreBackgroundImageView.snp.makeConstraints { galacticRestorationMake in
            galacticRestorationMake.centerX.equalToSuperview()
            galacticRestorationMake.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            galacticRestorationMake.width.equalTo(150)
            galacticRestorationMake.height.equalTo(55)
        }
        
        galacticRestorationGlobalScoreLabel.text = "\(galacticRestorationGlobalScore)"
        galacticRestorationGlobalScoreLabel.textAlignment = .center
        galacticRestorationGlobalScoreLabel.font = UIFont(name: "Caprasimo", size: 22)
        galacticRestorationGlobalScoreLabel.textColor = .white
        galacticRestorationScoreBackgroundImageView.addSubview(galacticRestorationGlobalScoreLabel)
        galacticRestorationGlobalScoreLabel.snp.makeConstraints { galacticRestorationMake in
            galacticRestorationMake.center.equalToSuperview()
        }
        
        galacticRestorationPauseButton.setImage(UIImage(named: "Setting"), for: .normal)
        galacticRestorationPauseButton.addTarget(self, action: #selector(galacticRestorationButtonPress), for: .touchUpInside)
        addGalacticSound(button: galacticRestorationPauseButton)
        view.addSubview(galacticRestorationPauseButton)
        galacticRestorationPauseButton.snp.makeConstraints { galacticRestorationMake in
            galacticRestorationMake.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            galacticRestorationMake.right.equalToSuperview().inset(10)
            galacticRestorationMake.width.height.equalTo(55)
        }
        
        galacticRestorationCentralImageView = UIImageView()
        galacticRestorationCentralImageView.contentMode = .scaleAspectFit
        galacticRestorationCentralImageView.isUserInteractionEnabled = true
        self.view.addSubview(galacticRestorationCentralImageView)
        
        galacticRestorationCentralImageView.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.width.height.equalTo(100)
        }
        
        for _ in 0..<4 {
            let galacticRestorationCardImageView = UIImageView()
            galacticRestorationCardImageView.contentMode = .scaleAspectFit
            galacticRestorationCardImageView.isUserInteractionEnabled = true
            galacticRestorationCardImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(galacticRestorationCardTapped(_:))))
            self.view.addSubview(galacticRestorationCardImageView)
            galacticRestorationCardImageViews.append(galacticRestorationCardImageView)
        }
        
        galacticRestorationPlaceCards()
        galacticRestorationPickRandomImage()
        
        galacticRestorationStartRotation()
        galacticRestorationStartCardRotation()
        galacticRestorationStartShuffleTimer()
    }
    
    func galacticRestorationPickRandomImage() {
        galacticRestorationCurrentImageIndex = Int.random(in: 0..<galacticRestorationImages.count)
        galacticRestorationCentralImageView.image = galacticRestorationImages[galacticRestorationCurrentImageIndex]
        
        let shuffledCardImages = galacticRestorationCardImages.shuffled()
        
        for (index, card) in galacticRestorationCardImageViews.enumerated() {
            card.image = shuffledCardImages[index]
        }
    }
    
    func galacticRestorationPlaceCards() {
        let galacticRestorationCardSize: CGFloat = 75
        let galacticRestorationRadius: CGFloat = 150
        
        for (index, card) in galacticRestorationCardImageViews.enumerated() {
            let galacticRestorationAngle = CGFloat(index) * .pi / 2
            let galacticRestorationXOffset = galacticRestorationRadius * cos(galacticRestorationAngle)
            let galacticRestorationYOffset = galacticRestorationRadius * sin(galacticRestorationAngle)
            
            card.snp.makeConstraints { make in
                make.centerX.equalTo(galacticRestorationCentralImageView).offset(galacticRestorationXOffset)
                make.centerY.equalTo(galacticRestorationCentralImageView).offset(galacticRestorationYOffset)
                make.width.height.equalTo(galacticRestorationCardSize)
            }
        }
    }
    
    private func galacticRestorationStartRotation() {
        galacticRestorationCandyRotationTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.galacticRestorationCentralImageView.transform = self.galacticRestorationCentralImageView.transform.rotated(by: .pi / 180)
        }
    }
    
    private func galacticRestorationStartCardRotation() {
        for card in galacticRestorationCardImageViews {
            let galacticRestorationCardRotationTimer = Timer.scheduledTimer(withTimeInterval: 0.005, repeats: true) { [weak self] _ in
                guard let self = self else { return }
                card.transform = card.transform.rotated(by: .pi / 180)
            }
            galacticRestorationCardRotationTimers.append(galacticRestorationCardRotationTimer)
        }
    }
    
    private func galacticRestorationStartShuffleTimer() {
        galacticRestorationShuffleTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { [weak self] _ in
            self?.galacticRestorationShuffleCards()
        }
    }
    
    private func galacticRestorationShuffleCards() {
        let shuffledCardImages = galacticRestorationCardImages.shuffled()
        for (index, card) in galacticRestorationCardImageViews.enumerated() {
            card.image = shuffledCardImages[index]
        }
    }
    
    @objc func galacticRestorationCardTapped(_ sender: UITapGestureRecognizer) {
        guard let tappedCard = sender.view as? UIImageView else { return }
        galacticSound()
        if tappedCard.image == galacticRestorationCardImages[galacticRestorationCurrentImageIndex] {
            galacticRestorationPickRandomImage()
            galacticRestorationScore()
            galacticRestorationCorrectSelectionsCount += 1
        } else {
            galacticRestorationOver(galacticRestorationScore: galacticRestorationCorrectSelectionsCount)
        }
    }

    func galacticRestorationPauseGame() {
        galacticRestorationIsGamePaused = true
        galacticRestorationCandyRotationTimer?.invalidate()
        galacticRestorationCardRotationTimers.forEach { $0.invalidate() }
        galacticRestorationShuffleTimer?.invalidate()
    }
    
    func galacticRestorationResumeGame() {
        galacticRestorationIsGamePaused = false
        galacticRestorationStartRotation()
        galacticRestorationStartCardRotation()
        galacticRestorationStartShuffleTimer()
    }
    
    func galacticRestorationRestartGame() {
        galacticRestorationCorrectSelectionsCount = 0
        galacticRestorationIsGamePaused = false
        galacticRestorationPickRandomImage()
        galacticRestorationStartRotation()
        galacticRestorationStartCardRotation()
        galacticRestorationStartShuffleTimer()
    }
    
    func galacticRestorationScore() {
        galacticRestorationGlobalScore += 1
        galacticRestorationGlobalScoreLabel.text = "\(galacticRestorationGlobalScore)"
    }
    
    func galacticRestorationOver(galacticRestorationScore: Int) {
        galacticRestorationPauseGame()
        let galacticRestorationController = GalacticRestorationGameOverViewController()
        galacticRestorationController.galacticRestorationScore = galacticRestorationScore
        galacticRestorationController.galacticRestorationOnReturnToMenu = { [weak self] in
            self?.dismiss(animated: false)
        }
        galacticRestorationController.galacticRestorationOnRestart = { [weak self] in
            self?.galacticRestorationRestartGame()
        }
        galacticRestorationController.modalPresentationStyle = .overCurrentContext
        self.present(galacticRestorationController, animated: false, completion: nil)
    }
    
    @objc private func galacticRestorationButtonPress() {
        galacticRestorationPauseGame()
        let galacticRestorationController = GalacticRestorationControllSoundViewController()
        galacticRestorationController.galacticRestorationOnReturnToMenu = { [weak self] in
            self?.dismiss(animated: false)
        }
        galacticRestorationController.galacticRestorationResume = { [weak self] in
            self?.galacticRestorationResumeGame()
        }
        galacticRestorationController.modalPresentationStyle = .overCurrentContext
        self.present(galacticRestorationController, animated: false, completion: nil)
    }
}
