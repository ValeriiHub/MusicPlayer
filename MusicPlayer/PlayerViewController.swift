//
//  PlayerViewController.swift
//  MusicPlayer
//
//  Created by Valerii D on 27.11.2021.
//

import UIKit
import AVFoundation

class PlayerViewController: UIViewController {
    
    @IBOutlet var holder: UIView!
    
    public var position = 0
    public var songs: [Song] = []
    
    var player: AVAudioPlayer?
    
    // User intarfsce elements
    
    let playPauseButton = UIButton()
    private let albumImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let songLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let artistLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let albumNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
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
            player?.volume = 0.5
            
            player?.play()
        } catch let error {
            print(error.localizedDescription)
        }
        
        //set up user interface elements
        
        // album cover
        albumImageView.frame = CGRect(x: 10,
                                      y: 10,
                                      width: holder.frame.size.width - 20,
                                      height: holder.frame.size.width - 20)
        albumImageView.image = UIImage(named: song.imageName)
        holder.addSubview(albumImageView)
        
        // labels
        songLabel.frame = CGRect(x: 10,
                                 y: albumImageView.frame.height + 10,
                                 width: holder.frame.size.width - 20,
                                 height: 70)
        
        albumNameLabel.frame = CGRect(x: 10,
                                      y: albumImageView.frame.height + 10 + 70,
                                      width: holder.frame.size.width - 20,
                                      height: 70)
        
        artistLabel.frame = CGRect(x: 10,
                                   y: albumImageView.frame.height + 10 + 140,
                                   width: holder.frame.size.width - 20,
                                   height: 70)
        
        songLabel.text = song.name
        albumNameLabel.text = song.albumName
        artistLabel.text = song.artistName
        
        holder.addSubview(songLabel)
        holder.addSubview(albumNameLabel)
        holder.addSubview(artistLabel)
        
        
        // player controls
        let nextButton = UIButton()
        let backButton = UIButton()
        
        // frames for button
        let yPosition = artistLabel.frame.origin.y + 70 + 20
        
        
        let size: CGFloat = 70
        playPauseButton.frame = CGRect(x: (holder.frame.size.width - size) / 2.0,
                                       y: yPosition,
                                       width: size,
                                       height: size)
        
        nextButton.frame = CGRect(x: (holder.frame.size.width - size - 20),
                                  y: yPosition,
                                  width: size,
                                  height: size)
        
        backButton.frame = CGRect(x: 20,
                                  y: yPosition,
                                  width: size,
                                  height: size)
        
        // add actions
        playPauseButton.addTarget(self, action: #selector(didTapPlayPauseButton(_:)), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didTapNextButton(_:)), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(didTapBackButton(_:)), for: .touchUpInside)

        // images for button
        playPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        nextButton.setBackgroundImage(UIImage(systemName: "forward.fill"), for: .normal)
        backButton.setBackgroundImage(UIImage(systemName: "backward.fill"), for: .normal)
        
        playPauseButton.tintColor = .black
        nextButton.tintColor = .black
        backButton.tintColor = .black
        
        holder.addSubview(playPauseButton)
        holder.addSubview(nextButton)
        holder.addSubview(backButton)
        
        
        
        // slider
        let slider = UISlider(frame: CGRect(x: 20, y: holder.frame.height - 60,
                                            width: holder.frame.width - 40, height: 20))
        slider.value = 0.5
        slider.addTarget(self, action: #selector(didSlideSlider(_:)), for: .valueChanged)
        holder.addSubview(slider)
    }
    
    @objc func didSlideSlider(_ slider: UISlider) {
        let value = slider.value
        player?.volume = value
        //adjust player volume
    }
    
    @objc func didTapPlayPauseButton(_ slider: UIButton) {
        if player?.isPlaying == true {
            player?.pause()
            playPauseButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
            
            //shrink image size
            UIView.animate(withDuration: 0.2) {
                self.albumImageView.frame = CGRect(x: 30,
                                                   y: 30,
                                                   width: self.holder.frame.size.width - 60,
                                                   height: self.holder.frame.size.width - 60)
            }
        } else {
            player?.play()
            playPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
            
            // increase image size
            UIView.animate(withDuration: 0.2) {
                self.albumImageView.frame = CGRect(x: 10,
                                                   y: 10,
                                                   width: self.holder.frame.size.width - 20,
                                                   height: self.holder.frame.size.width - 20)
            }
        }
    }
    
    @objc func didTapBackButton(_ slider: UIButton) {
        if position > 0 {
            position = position - 1
            player?.stop()
            
            for subview in holder.subviews {
                subview.removeFromSuperview()
            }
            configure()
        }
    }
    @objc func didTapNextButton(_ slider: UIButton) {
        if position < (songs.count - 1) {
            position = position + 1
            player?.stop()
            
            for subview in holder.subviews {
                subview.removeFromSuperview()
            }
            configure()
        }
    }
}
