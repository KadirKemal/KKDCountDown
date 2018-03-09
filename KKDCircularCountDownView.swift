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
    
    open var isAnimating: Bool {
        get { return (self.layer.animation(forKey: "value") != nil) ? true : false }
    }
    
    /**
     Set the ring layer to the default layer, cated as custom layer
     */
    internal var circularLayer: CircularProgressLayer {
        return self.layer as! CircularProgressLayer
    }
    
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
    
    @IBInspectable open var font: UIFont = UIFont.systemFont(ofSize: 36) {
        didSet {
            self.circularLayer.font = self.font
        }
    }
    
    @IBInspectable open var fontColor: UIColor = UIColor.black {
        didSet {
            self.circularLayer.fontColor = self.fontColor
        }
    }
    
    @IBInspectable open var winkingPeriod: CGFloat = 0.1 {
        didSet {
            self.circularLayer.winkingPeriod = self.winkingPeriod
        }
    }
    
    
    
    

    /**
     Overrides the default layer with the custom CircularProgressLayer class
     */
    override open class var layerClass: AnyClass {
        get {
            return CircularProgressLayer.self
        }
    }
    
    
    /**
     Overriden public init to initialize the layer and view
     */
    override public init(frame: CGRect) {
        super.init(frame: frame)
        // Call the internal initializer
        initialize()
    }
    
    /**
     Overriden public init to initialize the layer and view
     */
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // Call the internal initializer
        initialize()
    }
    
    /**
     This method initializes the custom CALayer
     For some reason didSet doesnt get called during initializing, so
     has to be done manually in here or else nothing would be drawn.
     */
    internal func initialize() {
        // Helps with pixelation and blurriness on retina devices
        self.layer.contentsScale = UIScreen.main.scale
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale * 2
        
        self.circularLayer.value = 0
        self.circularLayer.circleWidth = circleWidth
        self.circularLayer.circleColor = circleColor
        self.circularLayer.progressColor = progressColor
        
        self.circularLayer.font = font
        
        self.circularLayer.winkingPeriod = winkingPeriod
        
        
//        self.ringLayer.maxValue = maxValue
//        self.ringLayer.viewStyle = viewStyle
//        self.ringLayer.patternForDashes = patternForDashes
//        self.ringLayer.startAngle = startAngle
//        self.ringLayer.endAngle = endAngle
//        self.ringLayer.outerRingWidth = outerRingWidth
//        self.ringLayer.outerRingColor = outerRingColor
//        self.ringLayer.outerCapStyle = outStyle
//        self.ringLayer.innerRingWidth = innerRingWidth
//        self.ringLayer.innerRingColor = innerRingColor
//        self.ringLayer.innerCapStyle = inStyle
//        self.ringLayer.innerRingSpacing = innerRingSpacing
//        self.ringLayer.shouldShowValueText = shouldShowValueText
//        self.ringLayer.valueIndicator = valueIndicator
//        self.ringLayer.fontColor = fontColor
//        self.ringLayer.font = font
//        self.ringLayer.showFloatingPoint = showFloatingPoint
//        self.ringLayer.decimalPlaces = decimalPlaces
        
        // Sets background color to clear, this fixes a bug when placing view in tableview cells
        self.backgroundColor = UIColor.clear
        self.circularLayer.backgroundColor = UIColor.clear.cgColor
    }

    /**
     Overriden because of custom layer drawing in UICircularProgressRingLayer
     */
    open override func draw(_ rect: CGRect) {
        super.draw(rect)
    }

    open func setProgress(animationDuration: TimeInterval, completion:  (() -> Void)? = nil) {
        self.circularLayer.removeAllAnimations()
        
        self.circularLayer.animationDuration = animationDuration
        self.circularLayer.value = self.circularLayer.stepCount
        
        let animation = CABasicAnimation(keyPath: "value")
        animation.fromValue = 0
        animation.toValue = self.circularLayer.stepCount
        
        animation.duration = animationDuration
        animation.delegate = self
        
        self.circularLayer.add(animation, forKey: nil)
    }
    
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if(flag){
            self.delegate?.onFinishedCountDown(kkdCircularCountDownView: self)
        }
    }
        
}
