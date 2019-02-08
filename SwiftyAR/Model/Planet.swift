//
//  Planet.swift
//  SwiftyAR
//
//  Created by Aj Styles on 8.02.2019.
//  Copyright © 2019 Aj Styles. All rights reserved.
//

import UIKit

class Planet {
    private var _name: String
    
    var name: String {
        return _name
    }
    
    init(name: String) {
        self._name = name
    }
}
