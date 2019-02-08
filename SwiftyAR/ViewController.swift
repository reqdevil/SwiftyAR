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
    
    let minHeight: CGFloat = 0.2 // Cubes minimum height
    let maxHeight: CGFloat = 0.6 // Cubes maximum height
    let minDispersal: CGFloat = -4 // Cubes will not creating further than 4 meters
    let maxDispersal: CGFloat = 4 // Cubes will not creating further than -4 meters
    
    // Generate a location where cube will created
    func generateRandomVector() -> SCNVector3 {
        // 0...1 means that pick a number 0<=x<=1
        let x: CGFloat = CGFloat.random(in: minDispersal...maxDispersal)
        let y: CGFloat = CGFloat.random(in: minDispersal...maxDispersal)
        let z: CGFloat = CGFloat.random(in: minDispersal...maxDispersal)
        
        return SCNVector3(x, y, z)
    }
    
    // Generate a color that cube will be
    func generateRandomColor() -> UIColor {
        // 0...1 means that pick a number 0<=x<=1
        let red: CGFloat = CGFloat.random(in: 0...1)
        let green: CGFloat = CGFloat.random(in: 0...1)
        let blue: CGFloat = CGFloat.random(in: 0...1)
        let alpha: CGFloat = CGFloat.random(in: 0.5...1)
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    // Generate random size that cube will be
    func generateRandomSize() -> CGFloat {
        // 0...1 means that pick a number 0<=x<=1
        let height: CGFloat = CGFloat.random(in: minHeight...maxHeight)
        return height
    }
    
    func generateRandomAction() -> SCNAction {
        let rotationCoordinateArray = ["x", "y", "z"]
        let rotationCoordinate = Int.random(in: 0...2)
        let rotationTime = Double.random(in: 0...5)
        
        var action: SCNAction
        
        if rotationCoordinateArray[rotationCoordinate] == "x" {
            action = SCNAction.rotateBy(x: 2 * .pi, y: 0, z: 0, duration: rotationTime)
        }
        else if rotationCoordinateArray[rotationCoordinate] == "y" {
            action = SCNAction.rotateBy(x: 0, y: 2 * .pi, z: 0, duration: rotationTime)
        }
        else {
            action = SCNAction.rotateBy(x: 0, y: 0, z: 2 * .pi, duration: rotationTime)
        }
        
        return action
    }
    
    func generateCube() {
        let size = generateRandomSize()
        let color = generateRandomColor()
        let vector = generateRandomVector()
        let action = generateRandomAction()
        
        // Creating box
        let cube = SCNBox(width: size, height: size, length: size, chamferRadius: 0.03)
        
        // Creating color
        cube.materials.first?.diffuse.contents = color
        
        //Creating Location
        let cubeNode = SCNNode(geometry: cube)
        cubeNode.position = vector
        
        // Creating a animation
        let repeatAction = SCNAction.repeatForever(action)
        cubeNode.runAction(repeatAction)
        
        sceneView.scene.rootNode.addChildNode(cubeNode)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        // Showing yellow dots, stands for how AR understanding the real world
        sceneView.debugOptions = [.showFeaturePoints]
        // Creates a light, therefore objects are more beautiful to see
        sceneView.autoenablesDefaultLighting = false
        
    }
    
    @IBAction func addCubeButton(_ sender: Any) {
        generateCube()
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
