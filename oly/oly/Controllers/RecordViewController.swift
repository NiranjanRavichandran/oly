//
//  RecordViewController.swift
//  oly
//
//  Created by Niranjan Ravichandran on 6/1/18.
//  Copyright © 2018 Aviato. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData

class RecordViewController: OUITransparentViewController {
    
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder?
    
    var currentRecordingName: String = ""
    
    var stopButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        self.checkAudioPermissons { authorized in
            if authorized {
                //Start recording
                self.startRecording()
            } else {
                //Show error
            }
        }
        
        stopButton = UIButton(frame: CGRect.init(x: 0, y: self.view.frame.height - 45, width: 100, height: 35))
        stopButton.setTitle("Stop", for: .normal)
        stopButton.setTitleColor(.red, for: .normal)
        stopButton.addTarget(self, action: #selector(self.stopRecording), for: .touchUpInside)
        self.view.addSubview(stopButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkAudioPermissons(callback: @escaping (Bool) -> Void){
        recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.videoRecording, options: AVAudioSession.CategoryOptions.mixWithOthers)
            try recordingSession.setActive(true, options: AVAudioSession.SetActiveOptions.notifyOthersOnDeactivation)
            recordingSession.requestRecordPermission { allowed in
                DispatchQueue.main.async {
                    callback(allowed)
                }
            }
        } catch {
                callback(false)
        }
        
        callback(false)
    }
    
    func startRecording() {
        currentRecordingName = "recording\(RecordingNumbers.getNumberForRecording())" + GlobalConstants.defaultAudioFormat
        let audioFilename = getDocumentsDirectory().appendingPathComponent(currentRecordingName)
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder?.delegate = self
            audioRecorder?.record()
            
        } catch {
            finishRecording(success: false)
        }
    }
    
    @objc func stopRecording() {
        self.finishRecording(success: true)
        saveRecording()
        self.dismiss(animated: true, completion: nil)
    }
    
    func finishRecording(success: Bool) {
        audioRecorder?.stop()
        audioRecorder = nil
        
       self.updateRecordingNumberTable(for: self.currentRecordingName)
        
        //Save to core data
        
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    //MARK: - Core data helpers
    func saveRecording() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Recordings", in: context)
        let record = Record.init(name: self.currentRecordingName)
        _ = record.getManagedObject(entity: entity!, context: context)
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    
    //MARK: - Helper functions
    func updateRecordingNumberTable(for recordName: String) {
        let delimeter = GlobalConstants.defaultAudioFormat
        if let lastChar = recordName.components(separatedBy: delimeter).first?.last {
            if let number = Int64(String(lastChar)) {
                RecordingNumbers.addRecordingNumber(newNumber: number)
            }
        }
        RecordingNumbers.saveRecordingNumbersToDisk()
    }

}

extension RecordViewController: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
}
