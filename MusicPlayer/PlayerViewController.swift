//
//  PlayerViewController.swift
//  MusicPlayer
//
//  Created by Valerii D on 27.11.2021.
//

import UIKit

class PlayerViewController: UIViewController {

    public var position = 0
    public var songs: [Song] = []
    
    @IBOutlet var holder: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if holder.subviews.count == 1 {
            configure()
        }
    }
   
    func configure() {
        // set up player
        
        //set up user interface elements
    }
}
