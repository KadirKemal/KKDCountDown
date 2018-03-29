//
//  ViewController.swift
//  KKDCountDown
//
//  Created by kadirkemal on 02/27/2018.
//  Copyright (c) 2018 kadirkemal. All rights reserved.
//

import UIKit
import KKDCountDown

class ViewController: UIViewController {
    

    @IBOutlet weak var circularCountDown: KKDCircularCountDownView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        circularCountDown.circleWidth = 15
        circularCountDown.circleColor = .lightGray
        circularCountDown.progressColor = #colorLiteral(red: 0, green: 0.5628422499, blue: 0.3188166618, alpha: 1)
        circularCountDown.textColor = .white
        circularCountDown.textFont = UIFont(name: "Verdana", size: 80)!
        circularCountDown.textWinkingPeriod = 0.2
        circularCountDown.defaultText = "10"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onClickedStart(_ sender: Any) {
        circularCountDown.startCountDown(10) {
            let alert = UIAlertController(title: "Time is up", message: "", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })
            alert.addAction(cancel)
            self.present(alert, animated: true)
        }
    }
    
    
    @IBAction func onClickedStop(_ sender: Any) {
        circularCountDown.stopCountDown();
        
        let remaining = String(format: "%.2f", circularCountDown.remainingTime())
        let alert = UIAlertController(title: "Counting down was stopped", message: "Remaining duration is \(remaining) seconds", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })
        alert.addAction(cancel)
        self.present(alert, animated: true)
    }
    
    
    @IBAction func onClickedPause(_ sender: Any) {
        circularCountDown.pauseCountDown();
                
        let remaining = String(format: "%.2f", circularCountDown.remainingTime())
        let alert = UIAlertController(title: "Counting down was stopped", message: "Remaining duration is \(remaining) seconds", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })
        alert.addAction(cancel)
        self.present(alert, animated: true)
    }
    
    @IBAction func onClickedResume(_ sender: Any) {
        circularCountDown.resumeCountDown();
    }
    
    
}

