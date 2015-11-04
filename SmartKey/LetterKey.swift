//
//  LetterKey.swift
//  SmartKey App
//
//  Created by Alex Whitaker on 8/8/15.
//  Copyright (c) 2015 Alex Whitaker. All rights reserved.
//

import UIKit

class LetterKey : CustomKey {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.action = "letterPressed:"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}