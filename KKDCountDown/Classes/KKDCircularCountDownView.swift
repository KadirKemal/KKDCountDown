//
//  KKDCircularCountDownView.swift
//  CSLayerTest
//
//  Created by Kadir Kemal Dursun on 6.03.2018.
//  Copyright © 2018 Kadir Kemal Dursun. All rights reserved.
//

import UIKit

public protocol KKDCircularCountDownViewDelegate: class {
    
    func onFinishedCountDown(kkdCircularCountDownView: KKDCircularCountDownView)
    
}

@IBDesignable open class KKDCircularCountDownView: UIView, CAAnimationDelegate {
    
    open weak var delegate: KKDCircularCountDownViewDelegate?
    
    @IBInspectable open var circleWidth: CGFloat = 15 {
        didSet {
            self.circularLayer.circleWidth = self.circleWidth
        }
    }
    
    @IBInspectable open var circleColor: UIColor = UIColor.gray {
        didSet {
            self.circularLayer.circleColor = self.circleColor
        }
    }
    
    @IBInspectable open var progressColor: UIColor = UIColor.red {
        didSet {
            self.circularLayer.progressColor = self.progressColor
        }
    }
    
    
    @IBInspectable open var defaultText: String = "" {
        didSet {
            self.circularLayer.defaultText = self.defaultText
        }
    }
    
    @IBInspectable open var textFont: UIFont = UIFont.systemFont(ofSize: 36) {
        didSet {
            self.circularLayer.textFont = self.textFont
        }
    }
    
    @IBInspectable open var textColor: UIColor = UIColor.black {
        didSet {
            self.circularLayer.textColor = self.textColor
        }
    }
    
    @IBInspectable open var textWinkingPeriod: CGFloat = 0.1 {
        didSet {
            self.circularLayer.textWinkingPeriod = self.textWinkingPeriod
        }
    }
    
    
    
    
    
    internal var circularLayer: CircularProgressLayer {
        return self.layer as! CircularProgressLayer
    }
    
    /**
     Overrides the default layer with the custom CircularProgressLayer class
     */
    override open class var layerClass: AnyClass {
        get {
            return CircularProgressLayer.self
        }
    }

    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        // Call the internal initializer
        initialize()
    }

    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // Call the internal initializer
        initialize()
    }

    
    internal func initialize() {
        self.layer.contentsScale = UIScreen.main.scale
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale * 2
        
        self.circularLayer.value = 0
        self.circularLayer.circleWidth = circleWidth
        self.circularLayer.circleColor = circleColor
        self.circularLayer.progressColor = progressColor
        
        self.circularLayer.textFont = textFont
        self.circularLayer.defaultText = defaultText
        
        self.circularLayer.textWinkingPeriod = textWinkingPeriod
        self.circularLayer.animated = false

        self.backgroundColor = UIColor.clear
        self.circularLayer.backgroundColor = UIColor.clear.cgColor
    }

    
    open override func draw(_ rect: CGRect) {
        super.draw(rect)
    }

    open func startCountDown(_ countDownDuration: TimeInterval, completion:  (() -> Void)? = nil) {
        self.circularLayer.removeAllAnimations()
        
        self.circularLayer.animationDuration = countDownDuration
        self.circularLayer.value = self.circularLayer.stepCount
        self.circularLayer.animated = true
        
        let animation = CABasicAnimation(keyPath: "value")
        animation.fromValue = 0
        animation.toValue = self.circularLayer.stepCount
        
        animation.duration = countDownDuration
        animation.delegate = self
        
        self.circularLayer.add(animation, forKey: nil)
    }
    
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if(flag){
            self.delegate?.onFinishedCountDown(kkdCircularCountDownView: self)
        }
    }
        
}
