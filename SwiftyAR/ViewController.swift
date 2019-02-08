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

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
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
        
        // Show a cube shape to the screen
        let cube = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
        
        // Add cube some color
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.red
        cube.materials = [material]
        
        // Create a node to an object
        let cubeNode = SCNNode(geometry: cube)
        cubeNode.position = SCNVector3(0, 0, -0.5)
        
        // Add some action to the cube
        let rotation = SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 0, z: 2 * .pi, duration: 3))
        cubeNode.runAction(rotation)
        
        // Add the node to the screen for visualisation
        sceneView.scene.rootNode.addChildNode(cubeNode)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
}
