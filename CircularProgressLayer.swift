//
//  UICircularProgressLayer.swift
//  CSLayerTest
//
//  Created by Kadir Kemal Dursun on 6.03.2018.
//  Copyright © 2018 Kadir Kemal Dursun. All rights reserved.
//

import UIKit

extension UIColor {
    
    func blendColor(withColor: UIColor, ratio: CGFloat) -> UIColor{
        if(ratio >= 1){
            return self
        }
        
        if(ratio <= 0){
            return withColor
        }
        
        var myRed : CGFloat = 0
        var myGreen : CGFloat = 0
        var myBlue : CGFloat = 0
        var myAlpha: CGFloat = 0
        self.getRed(&myRed, green: &myGreen, blue: &myBlue, alpha: &myAlpha)
        
        var fRed : CGFloat = 0
        var fGreen : CGFloat = 0
        var fBlue : CGFloat = 0
        var fAlpha: CGFloat = 0
        withColor.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha)
        
        return UIColor(red: myRed * ratio + fRed * (1-ratio),
                       green: myGreen * ratio + fGreen * (1-ratio),
                       blue: myBlue * ratio + fBlue * (1-ratio),
                       alpha: 1)
    }
    
}

class CircularProgressLayer: CAShapeLayer {
    
    let stepCount: CGFloat = 1000
    
    @NSManaged var animationDuration: TimeInterval
    @NSManaged var value: CGFloat
    
    @NSManaged var circleWidth: CGFloat
    @NSManaged var circleColor : UIColor
    @NSManaged var progressColor : UIColor
    
    @NSManaged var font: UIFont
    @NSManaged var fontColor : UIColor
    
    @NSManaged var winkingPeriod: CGFloat
    
    var animated = false
    
    lazy private var valueLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    
    override func draw(in ctx: CGContext) {
        super.draw(in: ctx)
        UIGraphicsPushContext(ctx)
        
        drawBackgroundCircle()
        drawProgressCircle()
        drawValueLabel()
        
        UIGraphicsPopContext()
    }
    
    /**
     Watches for changes in the value property, and setNeedsDisplay accordingly
     */
    override class func needsDisplay(forKey key: String) -> Bool {
        if key == "value" {
            return true
        }
        
        return super.needsDisplay(forKey: key)
    }
    
    private func drawBackgroundCircle() {
        guard circleWidth > 0 else { return }
        
        let width = bounds.width
        let height = bounds.height
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = (min(width, height) - self.circleWidth)/2
        
        let path = UIBezierPath(arcCenter: center,
                                     radius: radius,
                                     startAngle: 0,
                                     endAngle: CGFloat(2.0 * Double.pi),
                                     clockwise: true)
        
        path.lineWidth = CGFloat(self.circleWidth)
        //path.lineCapStyle = .round //not important
        
        circleColor.setStroke()
        path.stroke()
    }
    
    private func drawProgressCircle() {
        guard circleWidth > 0 else { return }
        
        let width = bounds.width
        let height = bounds.height
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = (min(width, height) - self.circleWidth)/2
        
        let endAngle = ((CGFloat(value) / (stepCount / 2)) - 0.5) * CGFloat(Double.pi)
        
        let path = UIBezierPath(arcCenter: center,
                                     radius: radius,
                                     startAngle: CGFloat(-0.5 * Double.pi),
                                     endAngle: endAngle,
                                     clockwise: true)
        
        path.lineWidth = CGFloat(self.circleWidth)
        path.lineCapStyle = .round
        
        progressColor.setStroke()
        path.stroke()
    }
    
    private func drawValueLabel() {
        //guard shouldShowValueText else { return }
        let remaining = CGFloat(animationDuration) * (1 - value / stepCount)
        
        if remaining > 0 && remaining < 3 && (Int(remaining * 1000) % 1000) < Int(1000 * winkingPeriod) {
            return
        }
        
        valueLabel.font = self.font
        valueLabel.textAlignment = .center
        valueLabel.textColor = fontColor
        
        
        let t = Int(ceil(remaining))
        
        valueLabel.text = "\(t)"
        valueLabel.sizeToFit()
        
        valueLabel.center = CGPoint(x: bounds.midX, y: bounds.midY)
        //valueLabel.isHidden = remaining < 3 && (Int(remaining * 10) % 10) > 5
        valueLabel.drawText(in: self.bounds)
        
        
    }
}
