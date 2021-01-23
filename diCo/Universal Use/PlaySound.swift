//
//  PlaySound.swift
//  diCo
//
//  Created by Samsony Tuala on 12/28/20.
//  Copyright © 2020 lgdev. All rights reserved.
//

import Foundation
import AVFoundation
import AVKit

class PlaySound {
    static var audioPlayer:AVAudioPlayer!
    static func playSound(url: String) {
        //print(url)
        guard let c_url = URL(string: url) else { return}
        downloadFileFromURL(url: c_url)
    }
    static func downloadFileFromURL(url: URL){
        var downloadTask:URLSessionDownloadTask
        downloadTask = URLSession.shared.downloadTask(with: url) { (url, response, error) in
            self.play(url: url!)
        }
        downloadTask.resume()
    }
    static func play(url:URL) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url as URL)
            audioPlayer.prepareToPlay()
            audioPlayer.volume = 2.0
            audioPlayer.play()
        } catch let error as NSError {
            print(error.localizedDescription)
        } catch {
            print("AVAudioPlayer init failed")
        }
    }
}
