//
//  PlanetSelectorVC.swift
//  SwiftyAR
//
//  Created by Aj Styles on 8.02.2019.
//  Copyright © 2019 Aj Styles. All rights reserved.
//

import UIKit

class PlanetSelectorVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var planetPass: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let planetViewerVC = segue.destination as? PlanetViewerVC {
            planetViewerVC.planetShow = planetPass
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PlanetSelectorVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataServices.instance.getPlanets().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "planetCell") as? PlanetCell {
            let planetList = DataServices.instance.getPlanets()[indexPath.row]
            cell.configureCell(planet: planetList)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        planetPass = DataServices.instance.getPlanets()[indexPath.row].name
        performSegue(withIdentifier: "toPlanetViewerVC", sender: self)
    }
}
