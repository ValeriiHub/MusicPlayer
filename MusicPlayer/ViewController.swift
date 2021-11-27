//
//  ViewController.swift
//  MusicPlayer
//
//  Created by Valerii D on 26.11.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var table: UITableView!
    
    var songs: [Song] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self
        
        getSongs()
    }

    func getSongs() {
        songs.append(Song(name: "Background music",
                          albumName: "Other",
                          artistName: "Rnado",
                          imageName: "image1",
                          trackName: "song1"))
        songs.append(Song(name: "Havana",
                          albumName: "Havana album",
                          artistName: "Camilla",
                          imageName: "image2",
                          trackName: "song2"))
        songs.append(Song(name: "Viva la vida",
                          albumName: "Something",
                          artistName: "Coldplay",
                          imageName: "image3",
                          trackName: "song3"))
        songs.append(Song(name: "Background music",
                          albumName: "Other",
                          artistName: "Rnado",
                          imageName: "image1",
                          trackName: "song1"))
        songs.append(Song(name: "Havana",
                          albumName: "Havana album",
                          artistName: "Camilla",
                          imageName: "image2",
                          trackName: "song2"))
        songs.append(Song(name: "Viva la vida",
                          albumName: "Something",
                          artistName: "Coldplay",
                          imageName: "image3",
                          trackName: "song3"))
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let song = songs[indexPath.row]
        
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = song.name
        cell.detailTextLabel?.text = song.albumName
        cell.imageView?.image = UIImage(named: song.imageName)
        cell.textLabel?.font = UIFont(name: "Helvetica-Bold", size: 18)
        cell.detailTextLabel?.font = UIFont(name: "Helvetica-Bold", size: 16)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // present the player
        let position = indexPath.row
        
        //song
        guard let playerVC = storyboard?.instantiateViewController(withIdentifier: "player") as? PlayerViewController else { return}
        playerVC.songs = songs
        playerVC.position = position
        
        present(playerVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}
