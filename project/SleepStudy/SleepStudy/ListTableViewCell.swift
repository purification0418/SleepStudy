//
//  ListTableViewCell.swift
//  SleepStudy
//
//  Created by cscoi011 on 2017. 2. 6..
//  Copyright © 2017년 KKUMA. All rights reserved.
//

import UIKit
import AVFoundation

class ListTableViewCell: UITableViewCell {
    
    var selectedRecord:Record?

    @IBOutlet weak var listenImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var checkBox: UIImageView!
    @IBOutlet weak var recordLength: UILabel!
    
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var playImage: UIImageView!
    
    @IBOutlet weak var playProgress: UIProgressView!
    
    @IBOutlet weak var nowTime: UILabel!
    @IBOutlet weak var endTime: UILabel!
    
    
    @IBAction func touchButton(_ sender: UIButton) {
        if !isPaused{
            player?.pause()
            playImage.image=UIImage(named: "play-icon")
            isPaused=true
        }else{
            if player==nil{
                playSound()
                playImage.image=UIImage(named: "pause-1")
                isPaused=false
            }else{
                player!.play()
                playImage.image=UIImage(named: "pause-1")
                isPaused=false
            }
        }
    }

    var isPaused = true;
    var player: AVAudioPlayer?
    var audioDurationSeconds:Int=0
    
    func getTime(){
        var timer:Timer?
        timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true){  _ in
            let currentTime:Int = Int(self.player!.currentTime)
            if self.audioDurationSeconds==0{
                self.playProgress.progress=0
            }else{
                self.playProgress.progress = Float(currentTime) / Float(self.audioDurationSeconds)
                let hour = String(format: "%02d", currentTime/3600)
                let minute = String(format: "%02d", currentTime/60%60)
                let second = String(format: "%02d", currentTime%60)
                let length = "\(hour):\(minute):\(second)"
                self.nowTime.text=length
            }
        }
    }
    
    func playSound() {
        
        let url = selectedRecord?.path
        print(url!)
        do {
            let asset = AVURLAsset(url: url!, options: nil)
            let audioDuration = asset.duration
            audioDurationSeconds = Int(CMTimeGetSeconds(audioDuration))
            
            
            let hour = String(format: "%02d", self.audioDurationSeconds/3600)
            let minute = String(format: "%02d", self.audioDurationSeconds/60%60)
            let second = String(format: "%02d", self.audioDurationSeconds%60)
            let length = "\(hour):\(minute):\(second)"
            
            endTime.text=length
            player = try AVAudioPlayer(contentsOf: url!)
            guard let player = player else { return }
            
            
            player.prepareToPlay()
            player.play()
            getTime()
        } catch let error as NSError {
            print(error.description)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.playProgress.progress=0
        nowTime.text="00:00:00"
        endTime.text="00:00:00"
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
