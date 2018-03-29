//
//  KKDCircularCountDownView.swift
//  CSLayerTest
//
//  Created by Kadir Kemal Dursun on 6.03.2018.
//  Copyright © 2018 Kadir Kemal Dursun. All rights reserved.
//

import UIKit

@IBDesignable open class KKDCircularCountDownView: UIView, CAAnimationDelegate {
    
    var completionBlock: CountDownCompletion?
    private var startAnimationConvertTime: CFTimeInterval?
    
    private var timer: Timer?
    private var mach_info:mach_timebase_info?
    private var mach_start: UInt64 = 0
    private var mach_pause: UInt64 = 0
    
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
    
    @IBInspectable open var textColor: UIColor = UIColor.red {
        didSet {
            self.circularLayer.textColor = self.textColor
        }
    }
    
    @IBInspectable open var textWinkingPeriod: CGFloat = 0.2 {
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
        self.circularLayer.isAnimating = false

        self.backgroundColor = UIColor.clear
        self.circularLayer.backgroundColor = UIColor.clear.cgColor
        
    }

    
    open override func draw(_ rect: CGRect) {
        super.draw(rect)
    }

    public typealias CountDownCompletion = (() -> Void)
    
    open func startCountDown(_ countDownDuration: TimeInterval, completion:  CountDownCompletion? = nil) {
        mach_info = mach_timebase_info()
        guard mach_timebase_info(&mach_info!) == KERN_SUCCESS else { return }
        
        mach_start = mach_absolute_time()
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(timerTick), userInfo: nil, repeats: true)
    
        self.completionBlock = completion
        self.circularLayer.removeAllAnimations()
        
        self.circularLayer.speed = 1.0
        self.circularLayer.animationDuration = countDownDuration
        self.circularLayer.value = self.circularLayer.stepCount
        self.circularLayer.animated = true
        self.circularLayer.isAnimating = true
        
        self.circularLayer.beginTime = 0;
        
        self.startAnimationConvertTime = self.circularLayer.convertTime(CACurrentMediaTime(), from: nil)
        
        let animation = CABasicAnimation(keyPath: "value")
        animation.fromValue = 0
        animation.toValue = self.circularLayer.stepCount
        
        animation.duration = countDownDuration
        animation.isRemovedOnCompletion = false
        
        self.circularLayer.add(animation, forKey: nil)
    }
    open func stopCountDown(){
        guard self.circularLayer.isAnimating else {
            return
        }
        
        self.timer?.invalidate()
        
        self.circularLayer.isAnimating = false
        self.circularLayer.animated = false
        self.defaultText = ""
        
        self.circularLayer.removeAllAnimations()
        self.completionBlock = nil
    }
    
    open func pauseCountDown(){
        guard self.circularLayer.isAnimating else {
            return
        }
        
        self.circularLayer.isAnimating = false
        self.timer?.invalidate()
        mach_pause = mach_absolute_time()
        
        let pausedTime = self.circularLayer.convertTime(CACurrentMediaTime(), from: nil)
        self.circularLayer.speed = 0.0
        self.circularLayer.timeOffset = pausedTime
    }
    
    open func continueCountDown(){
        guard self.circularLayer.isAnimating != true else {
            return
        }
        
        self.mach_start = mach_start + mach_absolute_time() - mach_pause
        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(timerTick), userInfo: nil, repeats: true)
        
        self.circularLayer.isAnimating = true
        
        let pausedTime = self.circularLayer.timeOffset
        self.circularLayer.speed = 1.0
        self.circularLayer.timeOffset = 0.0
        
        let timeSincePause = self.circularLayer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime;
        self.circularLayer.beginTime = self.circularLayer.beginTime + timeSincePause;
    }
    
    open func remainingTime() -> CGFloat {
        return CGFloat(self.circularLayer.animationDuration) - CGFloat(self.circularLayer.convertTime(CACurrentMediaTime(), from: nil) - startAnimationConvertTime!)
    }
    

    @objc func timerTick() {
        let end = mach_absolute_time()
        let elapsed = end - mach_start
        
        let nanos = elapsed * UInt64(mach_info!.numer) / UInt64(mach_info!.denom)
        let t = TimeInterval(nanos) / TimeInterval(NSEC_PER_SEC)
        
        if(t > self.circularLayer.animationDuration){
            timer?.invalidate()
            
            self.circularLayer.isAnimating = false
            self.completionBlock?()
        }
    }
}
