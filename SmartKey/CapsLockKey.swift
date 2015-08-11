//
//  CapsLockKey.swift
//  SmartKey App
//
//  Created by Alex Whitaker on 8/10/15.
//  Copyright (c) 2015 Alex Whitaker. All rights reserved.
//

import UIKit

class CapsLockKey : CustomKey {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setTitle("\u{21EA}", forState: .Normal)
        self.action = "shiftDown:"
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
