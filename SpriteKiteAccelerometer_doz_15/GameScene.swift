//
//  GameScene.swift
//  SpriteKiteAccelerometer_doz_15
//
//  Created by Alexander Hoch on 27.01.21.
//  Copyright © 2021 zancor. All rights reserved.
//

import SpriteKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var motionManager: CMMotionManager!
    
    override func didMove(to view: SKView) {
        setPhysicWorld()
        
        
        createSun()
        
        motionManager = CMMotionManager()
        motionManager.startAccelerometerUpdates()
        motionManager.startGyroUpdates()
        motionManager.startDeviceMotionUpdates()
    }
    
    override func update(_ currentTime: TimeInterval) {
        if let accelerometerData = motionManager.accelerometerData {
            physicsWorld.gravity = CGVector(dx: accelerometerData.acceleration.x * 20, dy: accelerometerData.acceleration.y * 20)
            print("accelx:\(accelerometerData.acceleration.x)")
            print("accely:\(accelerometerData.acceleration.y)")
            print("accelz:\(accelerometerData.acceleration.z)")
        }
        if  motionManager.isGyroActive {
            print("gyrox:\(motionManager.gyroData?.rotationRate.x)")
            print("gyroy:\(motionManager.gyroData?.rotationRate.y)")
            print("gyroz:\(motionManager.gyroData?.rotationRate.z)")
               }
    }
    //************************************************
    func createSun(){
          let ball = SKSpriteNode(imageNamed:"ball")
          ball.size = CGSize(width: 100,height: 100)
          ball.position = CGPoint(x: self.frame.width/2,y: self.frame.height/2)
          
        ball.zPosition = 38
         ball.physicsBody = SKPhysicsBody(circleOfRadius: 50)
                       
                       ball.physicsBody?.mass =  5
                       ball.physicsBody?.friction = 100
          
          self.addChild(ball)
         
      }
    //*************************************************
    func setPhysicWorld(){
                 //erzeuge ein Rechteck mit Physic das so gross ist wie diese GameScene
                 let rect:CGRect = CGRect(x: 0,y: 0,width: self.frame.width,height: self.frame.height)
                 self.physicsBody = SKPhysicsBody(edgeLoopFrom: rect)
                 
                 //setze die Gravitation in diesem Rechteck
                 self.physicsWorld.gravity = CGVector(dx: 0, dy:-9.8)
              //**2**.
                 self.physicsWorld.contactDelegate = self
       }
    //**************************************************
    
    func touchDown(atPoint pos : CGPoint) {
    
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    
    }
    
    func touchUp(atPoint pos : CGPoint) {
       
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    
}
