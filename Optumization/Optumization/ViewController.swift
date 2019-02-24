//
//  ViewController.swift
//  Optumization
//
//  Created by Himanshu Minocha on 2/23/19.
//  Copyright © 2019 HackIllinois. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var employeeID: UITextField!
    var id: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        id = Int(employeeID.text!)
    }

    @IBAction func Login(_ sender: Any) {
        performSegue(withIdentifier: "OpenDailyMap", sender: self)
    }
    
}

