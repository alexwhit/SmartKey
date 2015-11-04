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
        //setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        //self.backgroundColor = UIColor(red: 153/255, green: 204/255, blue: 255/255, alpha: 255/255)
        
        // Sarah color scheme #1 - blues
        setTitleColor(UIColor(red: 82/255, green: 163/255, blue: 204/255, alpha: 255/255), forState: UIControlState.Normal)
        setTitleColor(UIColor(red: 214/255, green: 221/255, blue: 225/255, alpha: 255/255), forState: UIControlState.Highlighted)
        self.backgroundColor = UIColor(red: 238/255, green: 246/255, blue: 250/255, alpha: 255/255)
        
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 5
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}