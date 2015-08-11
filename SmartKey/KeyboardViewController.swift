//
//  KeyboardViewController.swift
//  SmartKey
//
//  Created by Alex Whitaker on 8/8/15.
//  Copyright (c) 2015 Alex Whitaker. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {
    
    var currentPageType : PageType = PageType.Uppercase
    var savedAlphabeticState : PageType = PageType.Uppercase
    
    var capsLock : Bool = false;
    var recentlyText : Bool = false;
    
    var lastShiftTap : NSDate?
    var lastSpaceBarTap : NSDate?
    
    enum PageType {
        case Lowercase
        case Uppercase
        case Numeric
        case Symbols
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
    
        // Add custom view sizing constraints here
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //blue
        //view.backgroundColor = UIColor(red: 32/255, green: 97/255, blue: 161/255, alpha: 255/255)
        
        //gray
        //view.backgroundColor = UIColor(red: 191/255, green: 191/255, blue: 191/255, alpha: 255/255)

        // Sarah color scheme #1 - blue
        view.backgroundColor = UIColor(red: 82/255, green: 163/255, blue: 204/255, alpha: 255/255)
        
        createKeyboardPage(currentPageType)
    }

    
    
    
    // creates a page of keys, given the page type as defined by an enum
    func createKeyboardPage(pageType : PageType) {
        view.subviews.map({ $0.removeFromSuperview() })
        
        var firstRowButtonTitles : [String] = []
        var secondRowButtonTitles :  [String] = []
        var thirdRowButtonTitles : [String] = []
        var bottomRowButtonTitles : [String] = []
        
        switch pageType {
        case PageType.Uppercase:
            firstRowButtonTitles = ["Q", "SP", "W","SP", "E","SP", "R","SP", "T","SP", "Y","SP", "U","SP", "I","SP", "O","SP","P"]
            secondRowButtonTitles = ["A","SP", "S","SP", "D","SP", "F","SP", "G","SP", "H","SP", "J","SP", "K","SP", "L","SP", "smart"]
            thirdRowButtonTitles = ["shiftDown","SP","SP", "Z","SP", "X","SP", "C","SP", "V","SP", "B","SP", "N","SP", "M","SP","SP", "backspace"]
            bottomRowButtonTitles = ["numeric","SP", "nextkeyboard","SP", "microphone","SP", "space","SP", "return"]
            break
        case PageType.Lowercase:
            firstRowButtonTitles = ["q","SP", "w","SP", "e","SP", "r","SP", "t","SP", "y","SP", "u","SP", "i","SP", "o","SP", "p"]
            secondRowButtonTitles = ["a","SP", "s","SP", "d","SP", "f","SP", "g","SP", "h","SP", "j","SP", "k","SP", "l","SP", "smart"]
            thirdRowButtonTitles = ["shiftUp","SP","SP", "z","SP", "x","SP", "c","SP", "v","SP", "b","SP", "n","SP", "m","SP","SP", "backspace"]
            bottomRowButtonTitles = ["numeric","SP", "nextkeyboard","SP", "microphone","SP", "space","SP", "return"]
            break
        case PageType.Numeric:
            firstRowButtonTitles = ["1","SP", "2","SP", "3","SP", "4","SP", "5","SP", "6","SP", "7","SP", "8","SP", "9","SP", "0"]
            secondRowButtonTitles = ["-","SP", "/","SP", ":","SP", ";","SP", "(","SP", ")","SP", "$","SP", "&","SP", "@","SP", "\u{0022}"]
            thirdRowButtonTitles = ["symbols","SP","SP", ".","SP", ",","SP", "?","SP", "!","SP", "'","SP", "SP","backspace"]
            bottomRowButtonTitles = ["alphabetic","SP", "nextkeyboard","SP", "microphone","SP", "space","SP", "return"]
            break
        case PageType.Symbols:
            firstRowButtonTitles = ["[","SP", "]","SP", "{","SP", "}","SP", "#","SP", "%","SP", "^","SP", "*","SP", "+","SP", "="]
            secondRowButtonTitles = ["_","SP", "\u{005C}","SP", "|","SP", "~","SP", "<","SP", ">","SP", "\u{20AC}","SP", "\u{00A3}","SP", "\u{00A5}","SP", "\u{25CF}"]
            thirdRowButtonTitles = ["numeric","SP","SP", ".","SP", ",","SP", "?","SP", "!","SP", "'","SP","SP", "backspace"]
            bottomRowButtonTitles = ["alphabetic","SP", "nextkeyboard", "SP","microphone","SP", "space","SP", "return"]
            break
        default:
            break
        }
        
        
        createButtons(firstRowButtonTitles, rowNumber: 1)
        createButtons(secondRowButtonTitles, rowNumber: 2)
        createButtons(thirdRowButtonTitles, rowNumber: 3)
        createButtons(bottomRowButtonTitles, rowNumber: 4)
    }
    

    
    
    
    // Creates the row of buttons, given button titles and a row number
    func createButtons(titles: [String], rowNumber: Int) {
        let screenSize : CGRect = UIScreen.mainScreen().bounds
        let screenWidth = screenSize.width
        
        var buttons = [CustomKey]()
    
        // For each button title, give it the appropriate functionality
        for title in titles {
            var button : CustomKey = CustomKey.buttonWithType(.Custom) as! CustomKey
            
            switch title {
            case "SP":
                button = Spacer.buttonWithType(.Custom) as! Spacer
                break
            case "space":
                button = SpaceKey.buttonWithType(.Custom) as! SpaceKey
                break
            case "return":
                button = ReturnKey.buttonWithType(.Custom) as! ReturnKey
                break
            case "backspace":
                button = BackspaceKey.buttonWithType(.Custom) as! BackspaceKey
                break
            case "shiftUp":
                if (capsLock) {
                    button = CapsLockKey.buttonWithType(.Custom) as! CapsLockKey
                } else {
                    button = ShiftUpKey.buttonWithType(.Custom) as! ShiftUpKey
                }
                break
            case "shiftDown":
                if (capsLock) {
                    button = CapsLockKey.buttonWithType(.Custom) as! CapsLockKey
                } else {
                    button = ShiftDownKey.buttonWithType(.Custom) as! ShiftDownKey
                }
                break
            case "numeric":
                button = SwitchToNumericKey.buttonWithType(.Custom) as! SwitchToNumericKey
                break
            case "alphabetic":
                button = SwitchToAlphabeticKey.buttonWithType(.Custom) as! SwitchToAlphabeticKey
                break
            case "symbols":
                button = SwitchToSymbolsKey.buttonWithType(.Custom) as! SwitchToSymbolsKey
                break
            case "nextkeyboard":
                button = NextKeyboardKey.buttonWithType(.Custom) as! NextKeyboardKey
            default:
                button = LetterKey.buttonWithType(.Custom) as! LetterKey
                button.setTitle(title, forState: .Normal)
                break
            }
            
            button.addTarget(self, action: button.action, forControlEvents: UIControlEvents.TouchUpInside)
            buttons.append(button)
            
        }
        
        // Add the buttons and row of buttons to the keyboard
        var row = UIView(frame: CGRectMake(CGFloat(3), CGFloat(6 + (53 * (rowNumber - 1))), screenWidth, CGFloat(46)))
        for button in buttons {
            row.addSubview(button)
        }
        self.view.addSubview(row)
        addConstraints(buttons, containingView: row)
    }
    
    
    // Method called when the smart key is pressed
    func smartKeyPressed(sender: AnyObject?) {

    }
    
    // Method called when the return key is pressed
    func returnPressed(sender: AnyObject?) {
        (textDocumentProxy as! UIKeyInput).insertText("\n")
    }
    
    
    // Method called when the space bar is pressed
    func spacePressed(sender: AnyObject?) {
        if (!spaceBarTimer()) {
            (textDocumentProxy as! UIKeyInput).insertText(" ")
        }
    }
    
    // Method to backspace
    func backspace(sender: AnyObject?) {
        (textDocumentProxy as! UIKeyInput).deleteBackward()
    }
    
    // Method to shift to uppercase
    func shiftUp(sender: AnyObject?) {
        currentPageType = PageType.Uppercase
        createKeyboardPage(currentPageType)
        capsLockTimer()
    }
    
    // Method to shift to lowercase
    func shiftDown(sender: AnyObject?) {
        currentPageType = PageType.Lowercase
        createKeyboardPage(currentPageType)
        capsLockTimer()
    }
    
    // Method called when the button to access the numeric keyboard is accessed
    func switchToNumeric(sender: AnyObject?) {
        if (currentPageType == PageType.Uppercase || currentPageType == PageType.Lowercase) {
            savedAlphabeticState = currentPageType
        }
        
        currentPageType = PageType.Numeric
        createKeyboardPage(currentPageType)
    }
    
    // Method called to switch back to alphabetic keyboard
    func switchToAlphabetic(sender: AnyObject?) {
        currentPageType = savedAlphabeticState;
        createKeyboardPage(currentPageType)
    }
    
    // Method called to access the symbols page
    func switchToSymbols(sender: AnyObject?) {
        currentPageType = PageType.Symbols
        createKeyboardPage(currentPageType)
    }
    
    // Method called when a character key  is pressed
    func letterPressed(sender: AnyObject?) {
        let button = sender as! UIButton
        let title = button.titleForState(.Normal)
        (textDocumentProxy as! UIKeyInput).insertText(title!)
        
        recentlyText = true;
        
        if (currentPageType == PageType.Uppercase && !capsLock) {
            currentPageType = PageType.Lowercase
            createKeyboardPage(currentPageType)
        }
    }
    
    
    // Add constraints to layout the buttons on the screen - this could be modularized better
    func addConstraints(buttons: [UIButton], containingView: UIView){
        
        for (index, button) in enumerate(buttons) {
            
            var topConstraint = NSLayoutConstraint(item: button, attribute: .Top, relatedBy: .Equal, toItem: containingView, attribute: .Top, multiplier: 1.0, constant: 1)
            
            var bottomConstraint = NSLayoutConstraint(item: button, attribute: .Bottom, relatedBy: .Equal, toItem: containingView, attribute: .Bottom, multiplier: 1.0, constant: -1)
            
            var leftConstraint : NSLayoutConstraint!
            
            if index == 0 {
                
                leftConstraint = NSLayoutConstraint(item: button, attribute: .Left, relatedBy: .Equal, toItem: containingView, attribute: .Left, multiplier: 1.0, constant: 1)
                
            }else{
                
                leftConstraint = NSLayoutConstraint(item: button, attribute: .Left, relatedBy: .Equal, toItem: buttons[index-1], attribute: .Right, multiplier: 1.0, constant: 1)
                if let obj = button as? Spacer {
                    var widthConstraint = NSLayoutConstraint(item: buttons[0], attribute: .Width, relatedBy: .Equal, toItem: button, attribute: .Width, multiplier: 10.0, constant: 0)
                    containingView.addConstraint(widthConstraint)
                }
                else if let obj = button as? SpaceKey {
                    var widthConstraint = NSLayoutConstraint(item: buttons[0], attribute: .Width, relatedBy: .Equal, toItem: button, attribute: .Width, multiplier: 0.28, constant: 0)
                    containingView.addConstraint(widthConstraint)
                }
                else if let obj = button as? ReturnKey {
                    var widthConstraint = NSLayoutConstraint(item: buttons[0], attribute: .Width, relatedBy: .Equal, toItem: button, attribute: .Width, multiplier: 0.55, constant: 0)
                    containingView.addConstraint(widthConstraint)
                }
                else {
                    var widthConstraint = NSLayoutConstraint(item: buttons[0], attribute: .Width, relatedBy: .Equal, toItem: button, attribute: .Width, multiplier: 1.0, constant: 0)
                    containingView.addConstraint(widthConstraint)
                }
            }
            
            var rightConstraint : NSLayoutConstraint!
            
            if index == buttons.count - 1 {
                
                rightConstraint = NSLayoutConstraint(item: button, attribute: .Right, relatedBy: .Equal, toItem: containingView, attribute: .Right, multiplier: 0.985, constant: -1)
                
            }else{
                
                rightConstraint = NSLayoutConstraint(item: button, attribute: .Right, relatedBy: .Equal, toItem: buttons[index+1], attribute: .Left, multiplier: 1.0, constant: -1)
            }
            
            containingView.addConstraints([topConstraint, bottomConstraint, rightConstraint, leftConstraint])
        }
    }
    
    
    func capsLockTimer() {
        if (capsLock) {
            capsLock = false;
            createKeyboardPage(currentPageType)
        }
        else {
            let now = NSDate()
            if let lastShiftTime = self.lastShiftTap {
                let timeSinceLastClick = now.timeIntervalSinceDate(lastShiftTime)
                if (timeSinceLastClick < 0.35) {
                    capsLock = true
                    currentPageType = PageType.Uppercase
                    createKeyboardPage(currentPageType)
                }
            }
        
            self.lastShiftTap = now
        }
    }
    
    
    
    func spaceBarTimer() -> Bool {
        var returnVal = false
        let now = NSDate()
        if let lastSpaceBar = self.lastSpaceBarTap {
            let timeSinceLastClick = now.timeIntervalSinceDate(lastSpaceBar)
            if (timeSinceLastClick < 0.35 && recentlyText) {
                (textDocumentProxy as! UIKeyInput).deleteBackward()
                (textDocumentProxy as! UIKeyInput).insertText(". ")
                
                currentPageType = PageType.Uppercase
                createKeyboardPage(currentPageType)
                
                recentlyText = false
                returnVal = true
            }
        }
        
        self.lastSpaceBarTap = now
        return returnVal
    }
    
    
    
    
    
    
    
    // Automatically-added methods that came when I imported the empty keyboard
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
    override func textWillChange(textInput: UITextInput) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(textInput: UITextInput) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        var proxy = self.textDocumentProxy as! UITextDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.Dark {
            textColor = UIColor.whiteColor()
        } else {
            textColor = UIColor.blackColor()
        }
        //self.nextKeyboardButton.setTitleColor(textColor, forState: .Normal)
    }
}
