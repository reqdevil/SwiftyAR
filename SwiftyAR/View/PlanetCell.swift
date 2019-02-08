//
//  PlanetCell.swift
//  SwiftyAR
//
//  Created by Aj Styles on 8.02.2019.
//  Copyright © 2019 Aj Styles. All rights reserved.
//

import UIKit

class PlanetCell: UITableViewCell {
    @IBOutlet weak var planetImage: UIImageView!
    @IBOutlet weak var planetName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(planet: Planet) {
        planetImage.image = UIImage(named: planet.name)
        planetName.text = planet.name.capitalized
    }
}
