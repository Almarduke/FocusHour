//
//  YearSelector.swift
//  FocusHour
//
//  Created by Midrash Elucidator on 2019/2/16.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

class YearSelector: UIStackView {
    
    @IBInspectable var zPosition: CGFloat = 1 {
        didSet {
            layer.zPosition = zPosition
        }
    }
    var isButtonsHidden: Bool = true {
        didSet {
            yearButtons.forEach { (button) in
                UIView.animate(withDuration: 0.3, animations: {
                    button.isHidden = self.isButtonsHidden
                    self.layoutIfNeeded()
                })
            }
        }
    }
    let years = PlantRecord.getRecordYears()
    var yearButtons: [DropdownButton] = []
    var achievementVC: AchievementVC!

    
    //MARK: Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }

    
    //MARK: Private Methods

    private func setupButtons() {
        for button in yearButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        yearButtons.removeAll()

        for year in PlantRecord.getRecordYears() {
            let button = DropdownButton()
            button.isHidden = isButtonsHidden
            button.setTitle("\(year)", for: .normal)
            button.addTarget(self, action: #selector(YearSelector.handleSelection(button:)), for: .touchUpInside)
            addArrangedSubview(button)
            yearButtons.append(button)
        }
    }
    
    @objc func handleSelection(button: UIButton) {
        let year = Int(button.titleLabel?.text ?? "0")!
        achievementVC.showAchievements(ofyear: year)
    }
    
    @objc private func changeBackgroundColor() {
        layer.opacity = 0.5
    }
    
    @objc private func resetBackgroundColor() {
        layer.opacity = 1.0
    }
}
