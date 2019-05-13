//
//  HomeViewController.swift
//  VideoTests
//
//  Created by Pedro Sánchez Castro on 08/05/2019.
//  Copyright © 2019 pedrosa.pro. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "HomeToPlayVideo" {
            let vcDestination = segue.destination as? PlayVideoViewController
            vcDestination?.segwayFrom = segue.identifier
        }
    }

}
