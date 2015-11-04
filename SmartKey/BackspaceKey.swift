//
//  BackspaceKey.swift
//  SmartKey App
//
//  Created by Alex Whitaker on 8/9/15.
//  Copyright (c) 2015 Alex Whitaker. All rights reserved.
//

import UIKit

class BackspaceKey : CustomKey {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setTitle("\u{232B}", forState: .Normal)
        self.action = "backspace:"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
