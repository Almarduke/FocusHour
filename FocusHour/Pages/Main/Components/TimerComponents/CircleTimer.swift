//
//  CircleTimeCounter.swift
//  FocusHour
//
//  Created by Midrash Elucidator on 2019/2/9.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

class CircleTimer: CircleView {
    var focusMinutes: Int = 0
    var focusSeconds: Int = 0  {
        didSet {
            focusMinutes = focusSeconds/60 > 0 ? focusSeconds/60 : 1
        }
    }
    
    var remainingTime: Int = 0 {  // The remainging time that you need to focus, calculated by SECONDS
        didSet {
            remainingMinutes = remainingTime / 60
            remainingSeconds = remainingTime % 60
            setNeedsDisplay()
        }
    }
    
    override func setup() {
        super.setup()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let ctx = UIGraphicsGetCurrentContext()
        // 设置背景，画圆形的背景
        ctx?.setFillColor(ColorKey.LightYellow.uiColor().cgColor)
        ctx?.setShouldAntialias(true)
        ctx?.addArc(center: drawCenter, radius: radius, startAngle: 0, endAngle: TWO_PI, clockwise: true)
        ctx?.drawPath(using: CGPathDrawingMode.fill)
        
        drawIconView(getIconImageBy(focusMinutes: focusSeconds / 60))
        drawHeadLabel(LocalizationKey.CountdownTitle.translate())
        drawFootLabel(timeFormat(), isTime: true)
    }
    
    func resetTime() {
        remainingTime -= 1
        focusSeconds += 1
    }
    
    func drawResult() {
        if remainingTime <= 0 {
            drawHeadLabel(LocalizationKey.NotificationSuccess.translate())
            drawFootLabel(LocalizationKey.Congratulations.translate(), isTime: false)
        } else if treeHasGrownUp() {
            drawHeadLabel(LocalizationKey.NotificationSuccess.translate())
            drawFootLabel(LocalizationKey.YouCanDoBetter.translate(), isTime: false)
        } else {
            drawIconView(UIImage(named: "BareTree"))
            drawHeadLabel(LocalizationKey.NotificationFailure.translate())
            drawFootLabel(LocalizationKey.Encouragement.translate(), isTime: false)
        }
    }
}


extension CircleTimer {
    
    func treeHasGrownUp() -> Bool {
        return focusSeconds >= TEN_MIN
    }
    
}
