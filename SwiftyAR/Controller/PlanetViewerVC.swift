//
//  ViewController.swift
//  SwiftyAR
//
//  Created by Aj Styles on 8.02.2019.
//  Copyright © 2019 Aj Styles. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class PlanetViewerVC: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    var planetShow: String!
    let baseNode = SCNNode()
    let planetNode = SCNNode()
    let textNode = SCNNode()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = false
        // Showing yellow dots, stands for how AR understanding the real world
        sceneView.debugOptions = [.showFeaturePoints]
        // Creates a light, therefore objects are more beautiful to see
        sceneView.autoenablesDefaultLighting = true
        
        addBaseNode()
        addText()
        addPlanet()
        addShip()
        
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(dissmiss(fromGesture:)))
        sceneView.addGestureRecognizer(gesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    func addBaseNode() {
        let baseLocation = SCNVector3(0, 0, -1)
        baseNode.position = baseLocation
        sceneView.scene.rootNode.addChildNode(baseNode)
    }
    
    func addPlanet() {
        let planet = SCNSphere(radius: 0.3)
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: planetShow)
        planet.materials = [material]
        planetNode.geometry = planet
        baseNode.addChildNode(planetNode)
        
        let planetRotate = SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 2 * .pi, z: 0, duration: 25))
        planetNode.runAction(planetRotate)
    }
    
    func addText() {
        let text = SCNText(string: planetShow.capitalized, extrusionDepth: 1)
        text.font = UIFont(name: "futura", size: 16)
        let scaleFactor = 0.1 / text.font.pointSize
        text.flatness = 0
        textNode.scale = SCNVector3(scaleFactor, scaleFactor, scaleFactor)
        textNode.geometry = text
        
        let max = textNode.boundingBox.max.x
        let min = textNode.boundingBox.min.x
        let midpoint = -((max - min) / 2 + min) * Float(scaleFactor)
        
        textNode.position = SCNVector3(midpoint, 0.35, 0)
        baseNode.addChildNode(textNode)
    }
    
    func addShip() {
        let orbitAction = SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 2 * .pi, z: 0, duration: 6))
        
        
        let shipUpAction = SCNAction.move(to: SCNVector3(-0.35, 0.2, 0), duration: 2)
        shipUpAction.timingMode = .easeInEaseOut
        
        let shipDownAction = SCNAction.move(to: SCNVector3(-0.35, -0.2, 0), duration: 2)
        shipDownAction.timingMode = .easeInEaseOut
        
        let upDownAction = SCNAction.repeatForever(SCNAction.sequence([shipUpAction, shipDownAction]))
        
        let ship = SCNScene(named: "art.scnassets/ship.scn")!
        if let shipNode = ship.rootNode.childNode(withName: "ship", recursively: true) {
            shipNode.scale = SCNVector3(0.2, 0.2, 0.2)
            shipNode.position = SCNVector3(-0.35, 0, 0)
            
            let rotateNode = SCNNode()
            baseNode.addChildNode(rotateNode)
            rotateNode.addChildNode(shipNode)
            rotateNode.runAction(orbitAction)
            shipNode.runAction(upDownAction)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    @objc func dissmiss(fromGesture gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .right {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
