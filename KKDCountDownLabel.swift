//
//  KKDCountDownLabel.swift
//  KKDCountDown
//
//  Created by Kadir Kemal Dursun on 28.02.2018.
//

import UIKit

class KKDCountDownLabel: UILabel {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    func animationText(text : String){
        if(self.text == text){
            return
        }
        self.alpha = 0
        self.text = text
        UIView.animate(withDuration: 0.3) {
            self.alpha = 1
        }
    }

}
