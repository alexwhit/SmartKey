//
//  CustomKey.swift
//  
//
//  Created by Alex Whitaker on 8/8/15.
//
//

import UIKit

class CustomKey : UIButton {
    
    var action : Selector = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.backgroundColor = UIColor(red: 153/255, green: 204/255, blue: 255/255, alpha: 255/255)
        self.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.layer.cornerRadius = 5
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}