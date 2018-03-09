//
//  ViewController.swift
//  KKDCountDown
//
//  Created by kadirkemal on 02/27/2018.
//  Copyright (c) 2018 kadirkemal. All rights reserved.
//

import UIKit
import KKDCountDown

class ViewController: UIViewController, KKDCircularCountDownViewDelegate {
    

    @IBOutlet weak var circularCountDown: KKDCircularCountDownView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        circularCountDown.circleWidth = 10
        circularCountDown.circleColor = .lightGray
        circularCountDown.progressColor = .blue
        circularCountDown.textColor = .blue
        circularCountDown.textFont = UIFont(name: "Verdana", size: 80)!
        circularCountDown.textWinkingPeriod = 0.2
        circularCountDown.defaultText = "20"
        
        circularCountDown.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onClickedStart(_ sender: Any) {
        circularCountDown.startCountDown(20)
    }
    
    
    func onFinishedCountDown(kkdCircularCountDownView: KKDCircularCountDownView) {
        
    }
}

