//
//  ConvertVideoViewController.swift
//  VideoTests
//
//  Created by Pedro Sánchez Castro on 08/05/2019.
//  Copyright © 2019 pedrosa.pro. All rights reserved.
//

import UIKit

class ConvertVideoViewController: UIViewController {
    
    var videoURL: URL?
    
    override func viewDidLoad() {
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("VideoURL is:\(videoURL?.absoluteString)")
    }
    
    func setVideoURL (videoURL: URL){
        self.videoURL = videoURL
    }
    
    // MARK: - IBAction
    
    @IBAction func load(_ sender: Any) {
    }
    
    
    
    @IBAction func converToSquare(_ sender: Any) {
    }
    
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "LoadToPlayVideo" {
            let vcDestination = segue.destination as? PlayVideoViewController
            vcDestination?.segwayFrom = segue.identifier
            vcDestination?.convertVC = self
        }
    }
}
