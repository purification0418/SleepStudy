//
//  RecordViewController.swift
//  SleepStudy
//
//  Created by cscoi011 on 2017. 1. 31..
//  Copyright © 2017년 KKUMA. All rights reserved.
//

import UIKit
import AVFoundation

class RecordViewController: UIViewController, AVAudioRecorderDelegate  {
    
    @IBOutlet weak var recordButton: UIButton!
    
    @IBOutlet weak var recordImage: UIImageView!
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    
    @IBOutlet weak var sessionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var stop = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        self.loadRecordingUI()
                    } else {
                        // failed to record!
                    }
                }
            }
        } catch {
            // failed to record!
        }
        // Do any additional setup after loading the view.
    }
    func loadRecordingUI() {
        recordButton.addTarget(self, action: #selector(recordTapped), for: .touchUpInside)
        
        //view.addSubview(recordButton)
    }
    func removepercent(str : String)-> String{
        var temp:String=""
        for i in str.characters{
            if i != "%"{
                temp.append(i)
            }
        }
        return temp
    }
    
    var filenamefa:URL?
    var dayStr:String?
    
    func startRecording() {
        let now = NSDate()
        let cal = NSCalendar(calendarIdentifier:NSCalendar.Identifier.gregorian)!
        let comps = cal.components([.year, .month, .day], from:now as Date)


        let filename = curClass!.id + String(comps.year!) + String(comps.month!) + String(comps.day!) + ".m4a"
        
        self.dayStr = "\(String(comps.year!))년 \(String(comps.month!))월 \(String(comps.day!))일"
        let audioFilename = getDocumentsDirectory().appendingPathComponent(filename)
        self.filenamefa = audioFilename
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
            
            recordImage.image=UIImage(named:"Stop")
            sessionLabel.text = "녹음 중"
            stop = false
            getTime()
        } catch {
            finishRecording(success: false)
        }
        
        
    }
    var currentTime = 0
    var lengthfa:String?
    func getTime(){
        self.currentTime = 0
        var timer:Timer?
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true){  _ in
            
            self.currentTime += 1
            let hour = String(format: "%02d", self.currentTime/3600)
            let minute = String(format: "%02d", self.currentTime/60%60)
            let second = String(format: "%02d", self.currentTime%60)
            let length = "\(hour):\(minute):\(second)"
            self.timeLabel.text = length
            self.lengthfa = length
            if self.stop{
                timer?.invalidate()
                return
            }
        }
    }
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func finishRecording(success: Bool) {
        audioRecorder.stop()
        audioRecorder = nil
        recordImage.image=UIImage(named:"Microphone-outlined-circular-button")
        self.stop = true
        curClass?.records += [Record(path: filenamefa!,date:dayStr!,length:lengthfa!)]
    }
    func recordTapped() {
        if audioRecorder == nil {
            startRecording()
        } else {
            finishRecording(success: true)
            let filemgrList = FileManager.default
            do{
                let fpath = String(describing: getDocumentsDirectory())
                let index = fpath.index(fpath.startIndex, offsetBy: 7)
                let temp = fpath.substring(from: index).appending("/")
                let filelist = try filemgrList.contentsOfDirectory(atPath: temp)
                for filename in filelist {
                    print("[4] \(filename)")
                }
            }catch{
                print("[4] 디렉토리 리스팅 실패!!")
            }
        }
    }
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
