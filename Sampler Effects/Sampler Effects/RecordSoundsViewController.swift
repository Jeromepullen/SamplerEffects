//
//  ViewController.swift
//
//  Sampler Effects
//
//  Created by Jerome Pullen Jr. on 7/27/21.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var btnStarRecording: UIButton!
    @IBOutlet weak var btnStopRecording: UIButton!
    
    // MARK: Variables
    
    var audioRecorder: AVAudioRecorder!
    
    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI(true)
    }
    
    // MARK: Actions

    @IBAction func recordAudio(_ sender: UIButton) {
        configureUI(false)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func stopRecord(_ sender: UIButton) {
        configureUI(true)
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
}

extension RecordSoundsViewController {
    // MARK: Methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
    
    func configureUI(_ isRecording: Bool) {
        recordingLabel.text = isRecording ? "Tap to Record" : "CURRENTLY RECORDING"
        btnStarRecording.isEnabled = isRecording
        btnStopRecording.isEnabled = !isRecording
    }
}

extension RecordSoundsViewController: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
            print("Recording was not successful")
        }
    }
}
