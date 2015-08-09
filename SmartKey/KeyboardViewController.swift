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
        
        //view.backgroundColor = UIColor(red: 32/255, green: 97/255, blue: 161/255, alpha: 255/255)
        view.backgroundColor = UIColor(red: 191/255, green: 191/255, blue: 191/255, alpha: 255/255)

        
        createKeyboardPage(currentPageType)
    }

    
    
    
    // creates a page of keys, given the page type as defined by an enum
    func createKeyboardPage(pageType : PageType) {
        var firstRowButtonTitles : [String] = []
        var secondRowButtonTitles :  [String] = []
        var thirdRowButtonTitles : [String] = []
        var bottomRowButtonTitles : [String] = []
        
        switch pageType {
        case PageType.Lowercase:
            firstRowButtonTitles = ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"]
            secondRowButtonTitles = ["A", "S", "D", "F", "G", "H", "J", "K", "L", "smart"]
            thirdRowButtonTitles = ["shiftUp", "Z", "X", "C", "V", "B", "N", "M", "backspace"]
            bottomRowButtonTitles = ["numeric", "nextkeyboard", "microphone", "space", "return"]
            break
        case PageType.Uppercase:
            firstRowButtonTitles = ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p"]
            secondRowButtonTitles = ["a", "s", "d", "f", "g", "h", "j", "k", "l", "smart"]
            thirdRowButtonTitles = ["shiftDown", "z", "x", "c", "v", "b", "n", "m", "backspace"]
            bottomRowButtonTitles = ["numeric", "nextkeyboard", "microphone", "space", "return"]
            break
        case PageType.Numeric:
            firstRowButtonTitles = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
            secondRowButtonTitles = ["-", "/", ":", ";", "(", ")", "$", "&", "@", "\u{0022}"]
            thirdRowButtonTitles = ["symbols", ".", ",", "?", "!", "'", "backspace"]
            bottomRowButtonTitles = ["alphabetic", "nextkeyboard", "microphone", "space", "return"]
            break
        case PageType.Symbols:
            firstRowButtonTitles = ["[", "]", "{", "}", "#", "%", "^", "*", "+", "="]
            secondRowButtonTitles = ["_", "\u{005C}", "|", "~", "<", ">", "\u{20AC}", "\u{00A3}", "\u{00A5}", "\u{25CF}"]
            thirdRowButtonTitles = ["numeric", ".", ",", "?", "!", "'", "backspace"]
            bottomRowButtonTitles = ["alphabetic", "nextkeyboard", "microphone", "space", "return"]
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
            case "space":
                button = SpaceKey.buttonWithType(.Custom) as! SpaceKey
                break
            case "return":
                button = ReturnKey.buttonWithType(.Custom) as! ReturnKey
                break
            case "shiftUp":
                button = ShiftUpKey.buttonWithType(.Custom) as! ShiftUpKey
                break
            case "shiftDown":
                button = ShiftDownKey.buttonWithType(.Custom) as! ShiftDownKey
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
        var row = UIView(frame: CGRectMake(CGFloat(0), CGFloat(6 + (51 * (rowNumber - 1))), screenWidth, CGFloat(43)))
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
        (textDocumentProxy as! UIKeyInput).insertText("\n");
    }
    
    
    // Method called when the space bar is pressed
    func spacePressed(sender: AnyObject?) {
        (textDocumentProxy as! UIKeyInput).insertText(" ");
    }
    
    // Method to shift to uppercase
    func shiftUp(sender: AnyObject?) {
        currentPageType = PageType.Uppercase
        createKeyboardPage(currentPageType)
    }
    
    // Method to shift to lowercase
    func shiftDown(sender: AnyObject?) {
        currentPageType = PageType.Lowercase
        createKeyboardPage(currentPageType)
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
                
                if let obj = button as? SpaceKey {
                    var widthConstraint = NSLayoutConstraint(item: buttons[0], attribute: .Width, relatedBy: .Equal, toItem: button, attribute: .Width, multiplier: 0.30, constant: 0)
                    containingView.addConstraint(widthConstraint)
                }
                else if let obj = button as? ReturnKey {
                    var widthConstraint = NSLayoutConstraint(item: buttons[0], attribute: .Width, relatedBy: .Equal, toItem: button, attribute: .Width, multiplier: 0.60, constant: 0)
                    containingView.addConstraint(widthConstraint)
                }
                else {
                    var widthConstraint = NSLayoutConstraint(item: buttons[0], attribute: .Width, relatedBy: .Equal, toItem: button, attribute: .Width, multiplier: 1.0, constant: 0)
                    containingView.addConstraint(widthConstraint)
                }
            }
            
            var rightConstraint : NSLayoutConstraint!
            
            if index == buttons.count - 1 {
                
                rightConstraint = NSLayoutConstraint(item: button, attribute: .Right, relatedBy: .Equal, toItem: containingView, attribute: .Right, multiplier: 1.0, constant: -1)
                
            }else{
                
                rightConstraint = NSLayoutConstraint(item: button, attribute: .Right, relatedBy: .Equal, toItem: buttons[index+1], attribute: .Left, multiplier: 1.0, constant: -1)
            }
            
            containingView.addConstraints([topConstraint, bottomConstraint, rightConstraint, leftConstraint])
        }
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
