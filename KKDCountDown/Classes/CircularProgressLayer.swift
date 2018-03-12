//
//  UICircularProgressLayer.swift
//  CSLayerTest
//
//  Created by Kadir Kemal Dursun on 6.03.2018.
//  Copyright © 2018 Kadir Kemal Dursun. All rights reserved.
//

import UIKit

class CircularProgressLayer: CAShapeLayer {
    
    let stepCount: CGFloat = 1000
    
    @NSManaged var animationDuration: TimeInterval
    @NSManaged var value: CGFloat
    
    @NSManaged var circleWidth: CGFloat
    @NSManaged var circleColor : UIColor
    @NSManaged var progressColor : UIColor
    
    @NSManaged var defaultText: String
    @NSManaged var textFont: UIFont
    @NSManaged var textColor : UIColor
    
    @NSManaged var textWinkingPeriod: CGFloat
    
    @NSManaged var animated: Bool
    @NSManaged var isAnimating: Bool
    
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
                                     clockwise: false)
        
        path.lineWidth = CGFloat(self.circleWidth)
        path.lineCapStyle = .round
        
        progressColor.setStroke()
        path.stroke()
    }
    
    private func drawValueLabel() {
        
        if(animated == false){
            drawValueLabelWithValue(defaultText)
        }else{
            let remaining = CGFloat(animationDuration) * (1 - value / stepCount)
            
            if textWinkingPeriod < 1 && remaining > 0 && (Int(remaining * 1000) % 1000) < Int(1000 * textWinkingPeriod) {
                return
            }
            
            let t = Int(ceil(remaining))
            drawValueLabelWithValue("\(t)")
        }
    }
    
    private func drawValueLabelWithValue(_ text : String) {
        valueLabel.font = self.textFont
        valueLabel.textAlignment = .center
        valueLabel.textColor = textColor
        
        valueLabel.text = text
        valueLabel.sizeToFit()
        
        valueLabel.center = CGPoint(x: bounds.midX, y: bounds.midY)
        valueLabel.drawText(in: self.bounds)
    }
}
