//
//  DataServices.swift
//  SwiftyAR
//
//  Created by Aj Styles on 8.02.2019.
//  Copyright © 2019 Aj Styles. All rights reserved.
//

import Foundation

class DataServices {
    static let instance = DataServices()
    
    private var planetList = [
        Planet(name: "sun"),
        Planet(name: "mercury"),
        Planet(name: "venus"),
        Planet(name: "earth"),
        Planet(name: "moon"),
        Planet(name: "mars"),
        Planet(name: "jupiter"),
        Planet(name: "saturn"),
        Planet(name: "uranus"),
        Planet(name: "neptune"),
        Planet(name: "earth night")
    ]
    
    func getPlanets() -> [Planet] {
        return planetList
    }
}
