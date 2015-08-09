//
//  SwitchToSymbolsKey.swift
//  SmartKey App
//
//  Created by Alex Whitaker on 8/9/15.
//  Copyright (c) 2015 Alex Whitaker. All rights reserved.
//

import UIKit

class SwitchToSymbolsKey : CustomKey {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setTitle("#+=", forState: .Normal)
        self.action = "switchToSymbols:"
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}