//
//  TimeCounterController.swift
//  FocusTime
//
//  Created by Midrash Elucidator on 2019/2/9.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class TimerVC: ViewController {

    let soundPlayer: SoundPlayer = SoundPlayer()
    var timer: Timer!
    var cancelable: Bool = true
    @IBOutlet weak var circleTimer: CircleTimer!
    @IBOutlet weak var stopButton: StopButton!
    @IBOutlet weak var returnButton: UIButton!
    @IBOutlet weak var soundButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITool.setToolButtonSize(returnButton, ratio: 432.0 / 512.0)
        UITool.setToolButtonSize(soundButton, ratio: 1.0)
        setSoundButtonStyle()
        returnButton.isEnabled = false
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (_) in
            if self.circleTimer.remainingTime > 0 {
                self.circleTimer.resetTime()
                self.cancelable = self.circleTimer.focusTime <= 10
                self.setStopButtonTitle()
            } else {
                self.end()
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setStopButtonTitle()
    }
    
    func setSoundButtonStyle() {
        let soundOn: Bool = soundPlayer.soundKey != .None
        soundButton.setImage(UIImage(named: soundOn ? "sound-on" : "sound-off"), for: .normal)
    }
    
    func setStopButtonTitle() {
        let title = cancelable ?
            "\(LocalizationKey.Cancel.translate()) (\(10 - self.circleTimer.focusTime))" :
            LocalizationKey.Giveup.translate()
        stopButton.setTitle(title, for: .normal)
    }
    
    @IBAction func StopButtonTapped(_ sender: Any) {
        if cancelable {
            soundPlayer.invalidate()
            dismiss(animated: true, completion: nil)
            return
        }
        
        let message = circleTimer.treeHasGrownUp() ?
            LocalizationKey.GiveupAlertHoldOnMessage.translate() : LocalizationKey.GiveupAlertDeathMessage.translate()
        let alert = UIAlertController(
            title: LocalizationKey.GiveupAlertTitle.translate(),
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(.init(
            title: LocalizationKey.Cancel.translate(),
            style: .cancel
        ))
        alert.addAction(.init(
            title: LocalizationKey.Yes.translate(),
            style: .destructive,
            handler: { (_) in self.end() }
        ))
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func returnToMainpage(_ sender: Any) {
        soundPlayer.invalidate()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func showMusicSelector(_ sender: Any) {
        guard let soundSelector = storyboard?.instantiateViewController(withIdentifier: "SoundSelector") as? SoundSelectorVC else { return }
        soundSelector.modalPresentationStyle = .popover
        soundSelector.preferredContentSize = CGSize(width: 200, height: 285)
        soundSelector.timerVC = self
        let popoverController = soundSelector.popoverPresentationController
        popoverController?.delegate = self
        popoverController?.sourceView = self.soundButton
        popoverController?.sourceRect = soundButton.bounds
        self.present(soundSelector, animated: true)
    }
    
    func end() {
        circleTimer.end()
        timer.invalidate()
        
        returnButton.isEnabled = true
        stopButton.isHidden = true
        soundButton.isHidden = true
        
        soundPlayer.invalidate()
    }
}

extension TimerVC: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
