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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let pieChartView = KKDCountDownView()
        pieChartView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 400)
        view.addSubview(pieChartView)
        
        pieChartView.startCountDown(seconds: 10)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

