//
//  SwitchToAlphabeticKey.swift
//  SmartKey App
//
//  Created by Alex Whitaker on 8/9/15.
//  Copyright (c) 2015 Alex Whitaker. All rights reserved.
//

import UIKit

class SwitchToAlphabeticKey : CustomKey {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setTitle("ABC", forState: .Normal)
        self.action = "switchToAlphabetic:"
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
