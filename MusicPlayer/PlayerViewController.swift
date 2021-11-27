//
//  PlayerViewController.swift
//  MusicPlayer
//
//  Created by Valerii D on 27.11.2021.
//

import UIKit
import AVFoundation

class PlayerViewController: UIViewController {

    var player: AVAudioPlayer?
    
    public var position = 0
    public var songs: [Song] = []
    
    @IBOutlet var holder: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if holder.subviews.count == 0 {
            configure()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let player = player {
            player.stop()
        }
    }
   
    func configure() {
        // set up player
        let song = songs[position]
        guard let urlString = Bundle.main.url(forResource: song.trackName, withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            
            player = try AVAudioPlayer(contentsOf: urlString)
            
            player?.play()
        } catch let error {
            print(error.localizedDescription)
        }
        
        //set up user interface elements
    }
    
    
}
