//
//  SetTimeViewController.swift
//  FocusHour
//
//  Created by Midrash Elucidator on 2019/2/4.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

class SetTimeVC: UIViewController {

    @IBOutlet weak var timeSetter: CircleSlider!
    @IBOutlet weak var startButton: StartButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var achievementButton: UIButton!
    @IBOutlet weak var coinLabelContainer: CoinLabelContainer!
    @IBOutlet weak var coinLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITool.setToolButtonSize(achievementButton, ratio: 1.0)
        UITool.setToolButtonSize(settingsButton, ratio: 1.0)
        UITool.setBackgroundImage(self.view, random: true)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(SetTimeVC.showTreeStore))
        timeSetter.iconView.addGestureRecognizer(gesture)
        timeSetter.iconView.isUserInteractionEnabled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UITool.setBackgroundImage(self.view, imageName: Theme.getCurrentTheme().backgroundImage)
        
        // timeSetter.drawHeadLabel(LocalizationKey.NotificationDeath.translate())
        // 如果调用上面那个方法会出现label只画出左边70%左右的情况，可能是因为viewWillAppear的时候获得的高度还是不保证准确的
        timeSetter.headLabel.text = LocalizationKey.SetTimeTitle.translate()
        startButton.setTitle(LocalizationKey.Start.translate(), for: .normal)
        coinLabelContainer.backgroundColor = Theme.getCurrentTheme().themeColor
        coinLabel.text = "\(PreferenceTool.getCoinNumber())"
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
        case SegueKey.ShowTimer.rawValue:
            guard let timerVC = segue.destination as? TimerVC else { return }
            let totalFocusHour = timeSetter.remainingMinutes * 60
            let background = view.backgroundColor
            timerVC.view.backgroundColor = background
            timerVC.circleTimer.remainingTime = totalFocusHour
        default:
            return
        }
    }
}

extension SetTimeVC {
    
    @objc func showTreeStore() {
        let controller = storyboard!.instantiateViewController(withIdentifier: "TreeStore") as! TreeStoreController
        controller.setTimeVC = self
        addChild(controller)
        view.addSubview(controller.view)
        controller.didMove(toParent: self)
    }
    
    func refresh() {
        timeSetter.refreshIconView()
        coinLabel.text = "\(PreferenceTool.getCoinNumber())"
    }
    
}
