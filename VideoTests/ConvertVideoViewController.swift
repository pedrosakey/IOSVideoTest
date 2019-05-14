//
//  ConvertVideoViewController.swift
//  VideoTests
//
//  Created by Pedro Sánchez Castro on 08/05/2019.
//  Copyright © 2019 pedrosa.pro. All rights reserved.
//

import UIKit
import AVKit

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
        cropVideoToSquare()
    }
    
    func cropVideoToSquare () {
        //output file
        let docFolder : String? = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last
       // let outputPath = URL(fileURLWithPath: docFolder ?? "").appendingPathComponent("output2.mov").absoluteString
        var outputPath = ""
        if let docFolder = docFolder {
        outputPath = docFolder
        outputPath.append("/output2.mov")
        }
        print(outputPath)
        if FileManager.default.fileExists(atPath: outputPath) {
            do {
                try FileManager.default.removeItem(atPath: outputPath)
            } catch {
                print("Error output file")
            }
        }
        
        //input file
        let asset = AVAsset(url: videoURL!)
        
        let composition = AVMutableComposition()
        composition.addMutableTrack(withMediaType: .video, preferredTrackID: kCMPersistentTrackID_Invalid)
        
        //input clip
        let clipVideoTrack: AVAssetTrack = asset.tracks(withMediaType: .video)[0]
        
        //make it square
        let videoComposition = AVMutableVideoComposition(propertiesOf: asset)
        videoComposition.renderSize = CGSize(width: clipVideoTrack.naturalSize.height, height: clipVideoTrack.naturalSize.height)
        videoComposition.frameDuration = CMTimeMake(value: 1, timescale: 30)
        
        let instruction = AVMutableVideoCompositionInstruction()
        instruction.timeRange = CMTimeRangeMake(start: CMTime.zero, duration: CMTimeMakeWithSeconds(60, preferredTimescale: 30))
        
        //rotate to portrait
        
        //export
        let exporter = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetHighestQuality)
        exporter?.videoComposition = videoComposition
        exporter?.outputURL = URL(fileURLWithPath: outputPath)
        exporter?.outputFileType = .mov
        
        exporter?.exportAsynchronously(completionHandler: {
            print("Exporting done!")
            if UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(outputPath) {
                UISaveVideoAtPathToSavedPhotosAlbum(outputPath, nil, nil, nil)
            }
            
        })

        
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
