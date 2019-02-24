//
//  ViewController.swift
//  Optumization
//
//  Created by Himanshu Minocha on 2/23/19.
//  Copyright © 2019 HackIllinois. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var employeeID = 0
    
    // MARK: Outlets
    @IBOutlet weak var employeeIDTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print(Constants.convertToCoordinates(address: "10 wescott drive Hopkinton, MA"))
        Constants.getAddresses(id: 55)
    }

    @IBAction func Login(_ sender: Any) {
        employeeID = Int(employeeIDTextField.text!) ?? 0
        performSegue(withIdentifier: "OpenDailyMap", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "OpenDailyMap") {
            let nextVC: MapScreen = segue.destination as! MapScreen
            nextVC.employeeId = self.employeeID
        }
    }
    
}

