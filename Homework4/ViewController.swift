//
//  ViewController.swift
//  Homework4
//
//  Created by Ремзи Билялов on 04.11.2021.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var labelPlayList: UILabel!
    
    @IBOutlet weak var imageFirstSong: UIImageView!
    @IBOutlet weak var imageSecondSong: UIImageView!

    @IBOutlet weak var buttonNameSong: UIButton!
    @IBOutlet weak var buttonNameSinger: UIButton!
    @IBOutlet weak var labelTimeSong: UILabel!
    
    @IBOutlet weak var labelTimeSong2: UILabel!
    @IBOutlet weak var buttonNameSong2: UIButton!
    @IBOutlet weak var buttonNameSinger2: UIButton!
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set image for song
        
        imageFirstSong.image = UIImage(named: "feduk")
        imageSecondSong.image = UIImage(named: "overpass")
        
        // Set value for time first song
        
        labelTimeSong.text = "2:42"
        labelTimeSong.font = .systemFont(ofSize: 18, weight: .semibold)
        labelTimeSong.textColor = .darkGray
        
        // Set value for time second song
        
        labelTimeSong2.text = "3:57"
        labelTimeSong2.font = .systemFont(ofSize: 18, weight: .semibold)
        labelTimeSong2.textColor = .darkGray
        
    }
    
    // Share data with segua.identefier
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showView",
        let destination = segue.destination as? SecondViewController {
        
        // Share data to the SecondVievController of first song
            
            destination.name = "Изменчивый мир"
            destination.nameSinger = "T-Fest feat. FEDUK"
            destination.imageSong11 = imageFirstSong.image!
            destination.timeSong = 162
            
            do {
                if let audioPath = Bundle.main.path(forResource: "Song1", ofType: "mp3"){
                    try destination.player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath))
                }
            } catch  {
                print("Error")
            }
     
            destination.player.play()
            
        }
        
        // Share data to the SecondVievController of second song
        
        if segue.identifier == "showView2",
        let destination = segue.destination as? SecondViewController {
            destination.name = "Overpass Graffiti"
            destination.nameSinger = "Ed Sheeran"
            destination.imageSong11 = imageSecondSong.image!
            destination.timeSong = 237
            
            do {
                if let audioPath = Bundle.main.path(forResource: "Song2", ofType: "mp3"){
                    try destination.player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath))
                }
            } catch  {
                print("Error")
            }
            
            destination.player.play()
           
        }
    }
}

