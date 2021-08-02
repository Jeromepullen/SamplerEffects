//
//  PlaySoundsViewController.swift
//  Sampler Effects
//
//  Created by Jerome Pullen Jr. on 7/27/21.
//

import UIKit
import AVFoundation
import CoreMotion

class PlaySoundsViewController: UIViewController {
    

    
    let manager = CMMotionManager()
    
    
    
    // MARK: Outlets
    
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    // MARK: Variables
    
    var recordedAudioURL:URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    
    enum ButtonType: Int { case slow = 0, fast, chipmunk, vader, echo, reverb }
    
    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        buttonContentMode()
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
    
    
    
    // MARK: Actions
    

    
    @IBAction func playSoundForButton(_ sender: UIButton) {
        
        manager.gyroUpdateInterval = 0.1
        manager.startGyroUpdates(to: .main) { (data, error) in

            let gyroX = Float(data!.rotationRate.x)
            
            debugPrint(gyroX)
                    
        }
        
        
                
        
        switch(ButtonType(rawValue: sender.tag)!) {
        //x is UP AND DOWN
        
            case .slow:
                playSound(rate: 0.5)
            case .fast:
                playSound(rate: 2)
                
        case .chipmunk:
            playSound(pitch: 2000)

            case .vader:
                playSound(pitch: -2000)
            case .echo:
                playSound(echo: true)
            case .reverb:
                playSound(reverb: true)
            
        }
        
        
        configureUI(.playing)
    }
    
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        stopAudio()
    }
}

extension PlaySoundsViewController {
    
    // MARK: Methods
    
    func buttonContentMode() {
        snailButton.imageView?.contentMode = .scaleAspectFit
        chipmunkButton.imageView?.contentMode = .scaleAspectFit
        rabbitButton.imageView?.contentMode = .scaleAspectFit
        vaderButton.imageView?.contentMode = .scaleAspectFit
        echoButton.imageView?.contentMode = .scaleAspectFit
        reverbButton.imageView?.contentMode = .scaleAspectFit
        stopButton.imageView?.contentMode = .scaleAspectFit
    }
    
}
