//
//  SwitchToNumericKey.swift
//  SmartKey App
//
//  Created by Alex Whitaker on 8/9/15.
//  Copyright (c) 2015 Alex Whitaker. All rights reserved.
//

import UIKit

class SwitchToNumericKey : CustomKey {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setTitle("123", forState: .Normal)
        self.action = "switchToNumeric:"
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
