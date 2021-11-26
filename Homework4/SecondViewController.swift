//
//  SecondViewController.swift
//  Homework4
//
//  Created by Ремзи Билялов on 04.11.2021.
//

import UIKit
import AVFoundation

class SecondViewController: UIViewController {
    
    @IBOutlet weak var labelPlayingFromAlbum: UILabel!
    
    @IBOutlet weak var labelSongName: UILabel!
    
    @IBOutlet weak var imageSong: UIImageView!
    
    @IBOutlet weak var labelNameSong1: UILabel!
    
    @IBOutlet weak var labelNameSinger: UILabel!
    
    @IBOutlet weak var buttomPlus: UIButton!
    @IBOutlet weak var buttonSetting: UIButton!
    
    @IBOutlet weak var buttonShuffle: UIButton!
    @IBOutlet weak var buttonRepeat: UIButton!
    
    @IBOutlet weak var sliderSong: UISlider!
    @IBOutlet weak var sliderVolum: UISlider!
    
    @IBOutlet weak var labelTimeStart: UILabel!
    @IBOutlet weak var labelTimeFinish: UILabel!
    
    
    // Variable for audioPlayer
    
    var player = AVAudioPlayer()
    
    // Variable for share data (name song/singer)
    
    var name = ""
    var nameSinger = ""
    
    // Variable for share image song
    
    var imageSong11 = UIImage()
    
    // Variable for timer
    
    var timer:Timer?
    
    // Variable for duration song
    
    var timeSong: Double = Double()
    
    // Variable for changing song in player
    
    var count = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // image Song
        
        imageSong.layer.cornerRadius = 5
        imageSong.image = imageSong11
        
        // labels
        
        labelSongName.text = name
        labelNameSong1.text = name
        labelNameSinger.text = nameSinger
        
        // slider song
        
        sliderSong.setThumbImage(UIImage(systemName: "circle.fill"), for: .normal)
        sliderSong.tintColor = .systemGreen
        sliderSong.maximumValue = Float(player.duration)
        sliderSong.addTarget(self, action: #selector(sliderValue), for: .valueChanged)
        
        // slider volum
        
        sliderVolum.setThumbImage(UIImage(systemName: "circle.fill"), for: .normal)
        sliderVolum.tintColor = .darkGray
        sliderVolum.maximumValue = Float(player.volume)
        player.volume = sliderVolum.value
        
        // create a timer with 1 sec interval
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        
        // label start/finish time
        
        labelTimeStart.text = ""
        labelTimeStart.textColor = .lightGray
        labelTimeStart.font = .systemFont(ofSize: 16)
        labelTimeFinish.text = ""
        labelTimeFinish.textColor = .lightGray
        labelTimeFinish.font = .systemFont(ofSize: 16)
        
        
    }

    // Timer for song from start to finish
    
    @objc func updateTime() {
        
        // Timer count from start
        
        let timePlayed = player.currentTime
            let minutes = Int(timePlayed / 60)
            let seconds = Int(timePlayed.truncatingRemainder(dividingBy: 60))
            labelTimeStart.text = NSString(format:"%02d:%02d", minutes, seconds) as String
        
        // Timer coun from end
        
        let difftime = player.currentTime - timeSong
            let minutes1 = Int(difftime / 60)
            let seconds1 = Int(-difftime.truncatingRemainder(dividingBy: 60))
            labelTimeFinish.text = NSString(format:"%02d:%02d", minutes1, seconds1) as String
        
        // Action thumb song along the way song
        
        sliderSong.setValue(Float(self.player.currentTime), animated: true)
        
    }
    
    // Slider volume song
    
    @IBAction func sliderVolum(_ sender: Any) {
        
        player.volume = sliderVolum.value
    }
    
    // Slider song at time
    
    @objc func sliderValue (sender: UISlider) {
        
        if sender == sliderSong {
            self.player.currentTime = TimeInterval(sender.value)
        }
    }
    
    // Button play/pause
    
    @IBAction func buttonPlayPause(_ sender: UIButton) {
        
        if player.isPlaying {
            
            player.pause()
            sender.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
            sender.tintColor = .darkGray
            
        } else {
            player.play()
            sender.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
            sender.tintColor = .darkGray
        }
    }
    
    // Button next song
    
    @IBAction func buttonNextSong(_ sender: Any) {
        
        buttonBackSong(self)
        
    }
    
    // Button back song
    
    @IBAction func buttonBackSong(_ sender: Any) {
        
        if self.count < 2 {
            self.count += 1
        } else {
            self.count = 1
        }
        
        let audioPath = Bundle.main.path(forResource: "Song\(self.count)", ofType: "mp3")
        self.player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
        
        if audioPath == Bundle.main.path(forResource: "Song1", ofType: "mp3") {
            labelSongName.text = "Изменчивый мир"
            labelNameSong1.text = "Изменчивый мир"
            labelNameSinger.text = "T-Fest feat. FEDUK"
            imageSong.image = UIImage(named: "feduk")
            timeSong = 162
        }
        
        if audioPath == Bundle.main.path(forResource: "Song2", ofType: "mp3") {
            labelSongName.text = "Overpass Graffiti"
            labelNameSong1.text = "Overpass Graffiti"
            labelNameSinger.text = "Ed Sheeran"
            imageSong.image = UIImage(named: "overpass")
            timeSong = 237
        }
        
        self.player.play()
        self.player.volume = sliderVolum.value
        
    }
    
    // Button share file song
    
    @IBAction func shareButton(_ sender: Any) {
        
        // Constants with sonf file
        let activityItem = URL.init(fileURLWithPath: Bundle.main.path(forResource: "Song1", ofType: "mp3")!)
        let activityItem2 = URL.init(fileURLWithPath: Bundle.main.path(forResource: "Song2", ofType: "mp3")!)

        // Constants is plaining song
        let audioPath = Bundle.main.path(forResource: "Song\(self.count)", ofType: "mp3")
        
        // Set condition for share the right song
        if audioPath == Bundle.main.path(forResource: "Song1", ofType: "mp3") {
            let activityVC = UIActivityViewController(activityItems: [activityItem], applicationActivities: nil)
            activityVC.popoverPresentationController?.sourceView = self.view
            self.present(activityVC,animated: true, completion: nil)
            
        } else {
            
            let activityVC = UIActivityViewController(activityItems: [activityItem2], applicationActivities: nil)
            activityVC.popoverPresentationController?.sourceView = self.view
            self.present(activityVC,animated: true, completion: nil)
            
        }
    }
    
    // Button hide View
    
    @IBAction func hideButton(_ sender: Any) {
        
        player.stop()
        dismiss(animated: true, completion: nil)
    }
    
    
}


