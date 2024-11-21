import UIKit
import SpriteKit

class Gladiator: SKScene, SKPhysicsContactDelegate {

    weak var GalacticRestoratioController: GladiatorController?
    private var GalacticRestoratioYellowPlanet: SKSpriteNode!
    private var GalacticRestoratioVerticalLeft: SKSpriteNode!
    private var GalacticRestoratioVerticalRight: SKSpriteNode!
    private var GalacticRestoratioBackgroundNode: SKSpriteNode!
    private var GalacticRestoratioScore = 0
    private var GalacticRestoratioGameIsOver = false
    private var GalacticRestoratioIsPaused = false

    var GalacticRestoratioVerticalNodeHeight: CGFloat = 200
    private let GalacticRestoratioVerticalNodeWidth: CGFloat = 30
    private let GalacticRestoratioVerticalLeftXPosition: CGFloat = 0
    private let GalacticRestoratioVerticalRightXPosition: CGFloat = 1

    private let GalacticRestoratioVerticalNodeSpeedRange: ClosedRange<CGFloat> = 1...2
    private let GalacticRestoratioVerticalNodeMoveDistance: CGFloat = 500

    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        GalacticRestoratioSetupBackground()
        GalacticRestoratioSetupYellowPlanet()
        GalacticRestoratioSetupVerticalNodes()
        GalacticRestoratioStartVerticalMovement()
        GalacticRestoratioStartYellowPlanetJumping()
    }

    private func GalacticRestoratioSetupBackground() {
        GalacticRestoratioBackgroundNode = SKSpriteNode(imageNamed: UserDefaults.standard.string(forKey: "galacticRestorationSelectedImageName") ?? "GalacticRestoration")
        GalacticRestoratioBackgroundNode.position = CGPoint(x: size.width / 2, y: size.height / 2)
        GalacticRestoratioBackgroundNode.size = size
        GalacticRestoratioBackgroundNode.zPosition = -1
        addChild(GalacticRestoratioBackgroundNode)
    }

    private func GalacticRestoratioStartYellowPlanetJumping() {
        let jumpHeight = size.height - GalacticRestoratioYellowPlanet.size.height - 150
        let fastUp = SKAction.moveBy(x: 0, y: jumpHeight, duration: 1)
        let slowDown = SKAction.moveBy(x: 0, y: -jumpHeight, duration: 2)
        let jumpSequence = SKAction.sequence([fastUp, slowDown])
        
        GalacticRestoratioYellowPlanet.run(SKAction.repeatForever(jumpSequence), withKey: "jumping")
    }

    private func GalacticRestoratioSetupYellowPlanet() {
        GalacticRestoratioYellowPlanet = SKSpriteNode(imageNamed: "YellowPlanet")
        GalacticRestoratioYellowPlanet.size = CGSize(width: 80, height: 80)
        GalacticRestoratioYellowPlanet.position = CGPoint(x: size.width / 2, y: GalacticRestoratioYellowPlanet.size.height / 2)
        GalacticRestoratioYellowPlanet.physicsBody = SKPhysicsBody(circleOfRadius: GalacticRestoratioYellowPlanet.size.width / 2)
        GalacticRestoratioYellowPlanet.physicsBody?.isDynamic = true
        GalacticRestoratioYellowPlanet.physicsBody?.categoryBitMask = GalacticRestoratioPhysicsCategory.yellowPlanet
        GalacticRestoratioYellowPlanet.physicsBody?.contactTestBitMask = GalacticRestoratioPhysicsCategory.verticalNode
        GalacticRestoratioYellowPlanet.physicsBody?.collisionBitMask = GalacticRestoratioPhysicsCategory.verticalNode
        addChild(GalacticRestoratioYellowPlanet)
    }

    private func GalacticRestoratioSetupVerticalNodes() {
        GalacticRestoratioVerticalLeft = SKSpriteNode(imageNamed: "Vertical")
        GalacticRestoratioVerticalLeft.size = CGSize(width: GalacticRestoratioVerticalNodeWidth, height: GalacticRestoratioVerticalNodeHeight)
        GalacticRestoratioVerticalLeft.position = CGPoint(x: GalacticRestoratioVerticalNodeWidth / 2, y: GalacticRestoratioVerticalNodeHeight / 2)
        GalacticRestoratioVerticalLeft.physicsBody = SKPhysicsBody(rectangleOf: GalacticRestoratioVerticalLeft.size)
        GalacticRestoratioVerticalLeft.physicsBody?.isDynamic = false
        GalacticRestoratioVerticalLeft.physicsBody?.categoryBitMask = GalacticRestoratioPhysicsCategory.verticalNode
        GalacticRestoratioVerticalLeft.physicsBody?.contactTestBitMask = GalacticRestoratioPhysicsCategory.yellowPlanet
        GalacticRestoratioVerticalLeft.physicsBody?.collisionBitMask = GalacticRestoratioPhysicsCategory.yellowPlanet
        addChild(GalacticRestoratioVerticalLeft)

        GalacticRestoratioVerticalRight = SKSpriteNode(imageNamed: "Vertical")
        GalacticRestoratioVerticalRight.size = CGSize(width: GalacticRestoratioVerticalNodeWidth, height: GalacticRestoratioVerticalNodeHeight)
        GalacticRestoratioVerticalRight.position = CGPoint(x: size.width - GalacticRestoratioVerticalNodeWidth / 2, y: GalacticRestoratioVerticalNodeHeight / 2)
        GalacticRestoratioVerticalRight.physicsBody = SKPhysicsBody(rectangleOf: GalacticRestoratioVerticalRight.size)
        GalacticRestoratioVerticalRight.physicsBody?.isDynamic = false
        GalacticRestoratioVerticalRight.physicsBody?.categoryBitMask = GalacticRestoratioPhysicsCategory.verticalNode
        GalacticRestoratioVerticalRight.physicsBody?.contactTestBitMask = GalacticRestoratioPhysicsCategory.yellowPlanet
        GalacticRestoratioVerticalRight.physicsBody?.collisionBitMask = GalacticRestoratioPhysicsCategory.yellowPlanet
        addChild(GalacticRestoratioVerticalRight)
    }

    private func GalacticRestoratioStartVerticalMovement() {
        let randomSpeedLeft = CGFloat.random(in: GalacticRestoratioVerticalNodeSpeedRange)
        let randomSpeedRight = CGFloat.random(in: GalacticRestoratioVerticalNodeSpeedRange)

        let maxY = size.height - GalacticRestoratioVerticalNodeHeight / 2
        let minY: CGFloat = GalacticRestoratioVerticalNodeHeight / 2

        let moveUpLeft = SKAction.moveTo(y: maxY, duration: TimeInterval(randomSpeedLeft))
        let moveDownLeft = SKAction.moveTo(y: minY, duration: TimeInterval(randomSpeedLeft))
        let leftSequence = SKAction.sequence([moveUpLeft, moveDownLeft])
        let repeatLeftMovement = SKAction.repeatForever(leftSequence)
        GalacticRestoratioVerticalLeft.run(repeatLeftMovement, withKey: "verticalMovementLeft")

        let moveUpRight = SKAction.moveTo(y: maxY, duration: TimeInterval(randomSpeedRight))
        let moveDownRight = SKAction.moveTo(y: minY, duration: TimeInterval(randomSpeedRight))
        let rightSequence = SKAction.sequence([moveUpRight, moveDownRight])
        let repeatRightMovement = SKAction.repeatForever(rightSequence)
        GalacticRestoratioVerticalRight.run(repeatRightMovement, withKey: "verticalMovementRight")
    }

    private func GalacticRestoratioUpdateScore() {
        GalacticRestoratioScore += 1
        GalacticRestoratioController?.galacticScore()
    }

    private func GalacticRestoratioGameOver() {
        GalacticRestoratioController?.galacticRestorationOver(galacticRestorationScore: GalacticRestoratioScore)
    }

    func GalacticRestoratioPauseGame() {
        if !GalacticRestoratioGameIsOver {
            GalacticRestoratioIsPaused = true
            isPaused = true
        }
    }

    func GalacticRestoratioResumeGame() {
        if !GalacticRestoratioGameIsOver {
            GalacticRestoratioIsPaused = false
            isPaused = false
        }
    }

    func GalacticRestoratioRestartGame() {
        GalacticRestoratioScore = 0
        GalacticRestoratioGameIsOver = false
        GalacticRestoratioIsPaused = false
        isPaused = false

        GalacticRestoratioYellowPlanet.removeAllActions()
        GalacticRestoratioVerticalLeft.removeAllActions()
        GalacticRestoratioVerticalRight.removeAllActions()

        removeAllChildren()

        GalacticRestoratioSetupBackground()
        GalacticRestoratioSetupYellowPlanet()
        GalacticRestoratioSetupVerticalNodes()

        let setupDelay = SKAction.wait(forDuration: 0.1)
        
        let startVerticalMovement = SKAction.run {
            self.GalacticRestoratioStartVerticalMovement()
        }

        let startPlanetJumping = SKAction.run {
            self.GalacticRestoratioStartYellowPlanetJumping()
        }

        let sequence = SKAction.sequence([setupDelay, startVerticalMovement, startPlanetJumping])
        run(sequence)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard !GalacticRestoratioGameIsOver else { return }
        guard let touch = touches.first else { return }
        
        let touchLocation = touch.location(in: self)
        galacticSound()
        if touchLocation.y > size.height - 100 {
            GalacticRestoratioPauseGame()
        } else if GalacticRestoratioIsPaused {
            GalacticRestoratioResumeGame()
        } else {
            GalacticRestoratioYellowPlanet.removeAction(forKey: "jumping")
        
            let moveLeft = SKAction.moveBy(x: -size.width * 0.6, y: 0, duration: 0.5)
            let moveRight = SKAction.moveBy(x: size.width * 0.5, y: 0, duration: 0.5)
        
            if touchLocation.x < size.width / 2 {
                GalacticRestoratioYellowPlanet.run(moveLeft) { [weak self] in
                    self?.GalacticRestoratioCheckCollisions()
                    if self?.GalacticRestoratioYellowPlanet.position.x ?? 0 < 0 {
                        self?.GalacticRestoratioGameOver()
                    }
                }
            } else {
                GalacticRestoratioYellowPlanet.run(moveRight) { [weak self] in
                    self?.GalacticRestoratioCheckCollisions()
                    if self?.GalacticRestoratioYellowPlanet.position.x ?? 0 > self?.size.width ?? 0 {
                        self?.GalacticRestoratioGameOver()
                    }
                }
            }
        }
    }

    private func GalacticRestoratioCheckCollisions() {}

    private func GalacticRestoratioHandleCollision() {
        GalacticRestoratioUpdateScore()
        GalacticRestoratioVerticalLeft.removeFromParent()
        GalacticRestoratioVerticalRight.removeFromParent()
        GalacticRestoratioYellowPlanet.removeFromParent()
        GalacticRestoratioSetupYellowPlanet()
        GalacticRestoratioSetupVerticalNodes()
        GalacticRestoratioStartVerticalMovement()
        GalacticRestoratioStartYellowPlanetJumping()
    }

    struct GalacticRestoratioPhysicsCategory {
        static let yellowPlanet: UInt32 = 0x1 << 0
        static let verticalNode: UInt32 = 0x1 << 1
    }

    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node == GalacticRestoratioYellowPlanet || contact.bodyB.node == GalacticRestoratioYellowPlanet {
            if contact.bodyA.node == GalacticRestoratioVerticalLeft || contact.bodyB.node == GalacticRestoratioVerticalLeft ||
                contact.bodyA.node == GalacticRestoratioVerticalRight || contact.bodyB.node == GalacticRestoratioVerticalRight {
                
                GalacticRestoratioHandleCollision()
            }
        }
    }
}
