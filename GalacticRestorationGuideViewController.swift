import UIKit
import SnapKit

class GalacticRestorationGuideViewController: UIViewController {
    
    private var galacticRestorationBackdropImageView = UIImageView()
    private var galacticRestorationCloseButton = UIButton()
    private var galacticRestorationDopImageView = UIImageView()
    private var galacticRestorationInstructionImageView = UIImageView()
    private var galacticRestorationInstructionLabel = UILabel()
    private var galacticRestorationTopImageView = UIImageView()
    
    private var galacticRestorationLeftButton = UIButton()
    private var galacticRestorationRightButton = UIButton()
    
    var galacticRestorationGame = 0
    
    private let instructionImageNames = [
        "Game1Img",
        "Game2Img",
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        galacticRestorationSetupBackdropImageView()
        galacticRestorationSetupTopImageView()
        galacticRestorationSetupDopImageView()
        galacticRestorationSetupCloseButton()
        galacticRestorationSetupInstructionImageView()
        galacticRestorationSetupInstructionLabel()
        galacticRestorationSetupLeftButton()
        galacticRestorationSetupRightButton()
        
        galacticRestorationSetupInstructionText()
    }
    
    private func galacticRestorationSetupBackdropImageView() {
        galacticRestorationBackdropImageView.image = UIImage(named: "Background")
        galacticRestorationBackdropImageView.contentMode = .scaleAspectFill
        view.addSubview(galacticRestorationBackdropImageView)
        
        galacticRestorationBackdropImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func galacticRestorationSetupTopImageView() {
        galacticRestorationTopImageView.image = UIImage(named: "TopImage1")
        galacticRestorationTopImageView.contentMode = .scaleAspectFit
        view.addSubview(galacticRestorationTopImageView)
        
        galacticRestorationTopImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(250)
            make.height.equalTo(100)
        }
    }
    
    private func galacticRestorationSetupDopImageView() {
        galacticRestorationDopImageView.image = UIImage(named: "Rectangle")
        galacticRestorationDopImageView.contentMode = .scaleToFill
        view.addSubview(galacticRestorationDopImageView)
        
        galacticRestorationDopImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(galacticRestorationDopImageView.snp.width).multipliedBy(1.3)
        }
    }
    
    private func galacticRestorationSetupCloseButton() {
        galacticRestorationCloseButton.setImage(UIImage(named: "Close"), for: .normal)
        galacticRestorationCloseButton.contentMode = .scaleAspectFit
        view.addSubview(galacticRestorationCloseButton)
        
        galacticRestorationCloseButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.equalToSuperview().inset(10)
            make.size.equalTo(45)
        }
        
        galacticRestorationCloseButton.addTarget(self, action: #selector(galacticRestorationCloseTapped), for: .touchUpInside)
        addGalacticSound(button: galacticRestorationCloseButton)
    }
    
    private func galacticRestorationSetupInstructionImageView() {
        let imageName = instructionImageNames[galacticRestorationGame]
        galacticRestorationInstructionImageView.image = UIImage(named: imageName)
        galacticRestorationInstructionImageView.contentMode = .scaleAspectFit
        view.addSubview(galacticRestorationInstructionImageView)
        
        galacticRestorationInstructionImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(galacticRestorationDopImageView.snp.top)
            make.width.equalTo(200)
            make.height.equalTo(100)
        }
    }
    
    private func galacticRestorationSetupInstructionLabel() {
        galacticRestorationInstructionLabel.font = UIFont(name: "Caprasimo", size: 30)
        galacticRestorationInstructionLabel.textColor = .white
        galacticRestorationInstructionLabel.textAlignment = .center
        galacticRestorationInstructionLabel.numberOfLines = 0
        galacticRestorationInstructionLabel.adjustsFontSizeToFitWidth = true
        galacticRestorationInstructionLabel.minimumScaleFactor = 0.49
        galacticRestorationDopImageView.addSubview(galacticRestorationInstructionLabel)
        
        galacticRestorationInstructionLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.77)
            make.height.equalTo(galacticRestorationDopImageView.snp.width).multipliedBy(1.2)
        }
    }
    
    private func galacticRestorationSetupInstructionText() {
        switch galacticRestorationGame {
        case 0:
            galacticRestorationInstructionLabel.text = "You are given a ball that will keep bouncing, and you need to hit it with either the left or the right shield. You simply need to tap on the corresponding part of the screen. The shields keep moving up and down. If you hit the ball 50 times in a row, you win; if not, you lose."
        default:
            galacticRestorationInstructionLabel.text = "You have a central ball and cards with different colored balls on the sides. You need to tap the card that shows the ball in the center. You must match it correctly 50 times in a row without making a mistake to win."
        }
    }
    
    private func galacticRestorationSetupLeftButton() {
        galacticRestorationLeftButton.setImage(UIImage(named: "ToBack"), for: .normal)
        galacticRestorationLeftButton.contentMode = .scaleAspectFit
        view.addSubview(galacticRestorationLeftButton)
        
        galacticRestorationLeftButton.snp.makeConstraints { make in
            make.centerY.equalTo(galacticRestorationInstructionLabel.snp.centerY)
            make.right.equalTo(galacticRestorationInstructionLabel.snp.left).offset(-20)
            make.size.equalTo(40)
        }
        
        galacticRestorationLeftButton.addTarget(self, action: #selector(galacticRestorationLeftButtonTapped), for: .touchUpInside)
        addGalacticSound(button: galacticRestorationLeftButton)
    }
    
    private func galacticRestorationSetupRightButton() {
        galacticRestorationRightButton.setImage(UIImage(named: "ToNext"), for: .normal)
        galacticRestorationRightButton.contentMode = .scaleAspectFit
        view.addSubview(galacticRestorationRightButton)
        
        galacticRestorationRightButton.snp.makeConstraints { make in
            make.centerY.equalTo(galacticRestorationInstructionLabel.snp.centerY)
            make.left.equalTo(galacticRestorationInstructionLabel.snp.right).offset(20)
            make.size.equalTo(40)
        }
        
        galacticRestorationRightButton.addTarget(self, action: #selector(galacticRestorationRightButtonTapped), for: .touchUpInside)
        addGalacticSound(button: galacticRestorationRightButton)
    }
    
    @objc private func galacticRestorationLeftButtonTapped() {
        galacticRestorationGame = max(galacticRestorationGame - 1, 0)
        updateViewForCurrentGame()
    }
    
    @objc private func galacticRestorationRightButtonTapped() {
        galacticRestorationGame = min(galacticRestorationGame + 1, instructionImageNames.count - 1)
        updateViewForCurrentGame()
    }
    
    private func updateViewForCurrentGame() {
        galacticRestorationSetupInstructionImageView()
        galacticRestorationSetupInstructionText()
    }
    
    @objc private func galacticRestorationCloseTapped() {
        dismiss(animated: true, completion: nil)
    }
}
