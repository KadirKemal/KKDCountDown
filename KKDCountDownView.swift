//
//  KKDCountDownView.swift
//  KKDCountDown
//
//  Created by Kadir Kemal Dursun on 27.02.2018.
//

import UIKit


public class KKDCountDownView: UIView {
    
    private let countLabel = KKDCountDownLabel()
    
    private let pieView = KKDPieView()
    private var timer: Timer?
    
    private var milliseconds: Int = 0
    private var millisecondsPassed: Int = 0
    
    var circleLayer: CAShapeLayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isOpaque = false // when overriding drawRect, you must specify this to maintain transparency.

    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func draw(_ rect: CGRect) {
        pieView.frame = self.bounds
        countLabel.frame = self.bounds
        
        countLabel.font = UIFont(name: "Verdana", size: 40)
        countLabel.textAlignment = .center
        
//        pieView.segments = [
//            PieSegment(color: .blue, value: 60),
//            PieSegment(color: .red, value: 30),
//            PieSegment(color: .green, value: 25),
//            PieSegment(color: .yellow, value: 10)
//        ]

        self.addSubview(pieView)
        self.addSubview(countLabel)
    }

    public func startCountDown(seconds: Int){
        countLabel.text = String(seconds)
        self.milliseconds = seconds * 1000
        self.millisecondsPassed = 0
        
        pieView.segments = [
            PieSegment(color: .clear, value: CGFloat(self.milliseconds)),
            PieSegment(color: .red, value: CGFloat(self.millisecondsPassed))
        ]
        
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: (#selector(timerLoop)), userInfo: nil, repeats: true)
    }
    
    @objc func timerLoop() {
        milliseconds = milliseconds - 10
        millisecondsPassed = millisecondsPassed + 10
        
        countLabel.text = String(format: "%.2f", Double(CGFloat(milliseconds) / 1000)) //(text: String(format: "%.3f", Double(CGFloat(milliseconds) / 1000)))
        
        pieView.segments = [
            PieSegment(color: .clear, value: CGFloat(self.milliseconds)),
            PieSegment(color: .red, value: CGFloat(self.millisecondsPassed))
        ]
        
        if(milliseconds == 0){
            timer?.invalidate()
        }
    }
}
