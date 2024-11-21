import UIKit
import SnapKit

class ChineseHistory: UIViewController {
    
    private var galacticRestorationBackdropImageView = UIImageView()
    private var galacticRestorationCloseButton = UIButton()
    private var galacticRestorationDopImageView = UIImageView()
    private var galacticRestorationInstructionImageView = UIImageView()
    private var galacticRestorationInstructionLabel = UILabel()
    
    private var galacticRestorationLeftButton = UIButton()
    private var galacticRestorationRightButton = UIButton()
    
    var galacticRestorationStoryIndex = 0
    
    private let chineseHistoricalStories = [
        "The Great Wall of China was built to protect China from invasions. It stretches over 13,000 miles and took many dynasties to complete.",
        "The Tang Dynasty is known as the golden age of Chinese civilization, with advancements in poetry, art, and technology.",
        "Emperor Qin Shi Huang was the first emperor of China, known for unifying the country and building the Terracotta Army to protect his tomb.",
        "The story of the Monkey King, Sun Wukong, is one of the most famous Chinese tales, showcasing bravery, mischief, and wisdom.",
        "The invention of paper during the Han Dynasty revolutionized communication and culture in China and later the world.",
        "Confucius, a philosopher in ancient China, emphasized the importance of education, ethics, and respect for others.",
        "The Silk Road was an ancient trade route that connected China with Europe and facilitated the exchange of goods, culture, and ideas.",
        "The famous philosopher Laozi is credited with writing the Tao Te Ching, the foundation of Taoism, which emphasizes living in harmony with the Tao (the way).",
        "The story of Mulan is about a young woman who disguised herself as a man to take her father’s place in the army, demonstrating courage and filial piety.",
        "The Battle of Red Cliffs, one of the most significant battles in Chinese history, was a decisive victory that helped end the Han Dynasty's downfall."
    ]
    
    private let historicalFactImages = [
        "GreatWallImage",
        "TangDynastyImage",
        "QinShiHuangImage",
        "MonkeyKingImage",
        "PaperInventionImage",
        "ConfuciusImage",
        "SilkRoadImage",
        "LaoziImage",
        "MulanImage",
        "RedCliffsImage"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        galacticRestorationSetupBackdropImageView()
        galacticRestorationSetupDopImageView()
        galacticRestorationSetupCloseButton()
        galacticRestorationSetupInstructionImageView()
        galacticRestorationSetupInstructionLabel()
        galacticRestorationSetupLeftButton()
        galacticRestorationSetupRightButton()
        
        updateViewForCurrentStory()
    }
    
    private func galacticRestorationSetupBackdropImageView() {
        galacticRestorationBackdropImageView.image = UIImage(named: "Background")
        galacticRestorationBackdropImageView.contentMode = .scaleAspectFill
        view.addSubview(galacticRestorationBackdropImageView)
        
        galacticRestorationBackdropImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func galacticRestorationSetupDopImageView() {
        galacticRestorationDopImageView.image = UIImage(named: "Rectangle")
        galacticRestorationDopImageView.contentMode = .scaleToFill
        view.addSubview(galacticRestorationDopImageView)
        
        galacticRestorationDopImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(galacticRestorationDopImageView.snp.width).multipliedBy(0.8)
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
        galacticRestorationInstructionImageView.contentMode = .scaleAspectFit
        view.addSubview(galacticRestorationInstructionImageView)
        
        galacticRestorationInstructionImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(galacticRestorationDopImageView.snp.top).offset(-20)
            make.width.equalTo(200)
            make.height.equalTo(150)
        }
    }
    
    private func galacticRestorationSetupInstructionLabel() {
        galacticRestorationInstructionLabel.font = UIFont(name: "Caprasimo", size: 20)
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
        galacticRestorationStoryIndex = max(galacticRestorationStoryIndex - 1, 0)
        updateViewForCurrentStory()
    }
    
    @objc private func galacticRestorationRightButtonTapped() {
        galacticRestorationStoryIndex = min(galacticRestorationStoryIndex + 1, chineseHistoricalStories.count - 1)
        updateViewForCurrentStory()
    }
    
    private func updateViewForCurrentStory() {
        galacticRestorationInstructionLabel.text = chineseHistoricalStories[galacticRestorationStoryIndex]
        
        let imageName = historicalFactImages[galacticRestorationStoryIndex]
        galacticRestorationInstructionImageView.image = UIImage(named: imageName)
    }
    
    @objc private func galacticRestorationCloseTapped() {
        dismiss(animated: true, completion: nil)
    }
}
