//
//  KeyboardViewController.swift
//  SmartKey
//
//  Created by Alex Whitaker on 8/8/15.
//  Copyright (c) 2015 Alex Whitaker. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {
    
    @IBOutlet var nextKeyboardButton: UIButton!
    
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
    
        // Perform custom UI setup here
        self.nextKeyboardButton = UIButton.buttonWithType(.System) as! UIButton
    
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), forState: .Normal)
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.setTranslatesAutoresizingMaskIntoConstraints(false)
    
        self.nextKeyboardButton.addTarget(self, action: "advanceToNextInputMode", forControlEvents: .TouchUpInside)
        
        self.view.addSubview(self.nextKeyboardButton)
        
        view.backgroundColor = UIColor(red: 32/255, green: 97/255, blue: 161/255, alpha: 255/255)
        
        
        createKeyboardPage(PageType.Symbols)
    
    
        var nextKeyboardButtonLeftSideConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1.0, constant: 0.0)
        var nextKeyboardButtonBottomConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
        self.view.addConstraints([nextKeyboardButtonLeftSideConstraint, nextKeyboardButtonBottomConstraint])
    }

    
    func createKeyboardPage(pageType : PageType) {
        var firstRowButtonTitles : [String] = []
        var secondRowButtonTitles :  [String] = []
        var thirdRowButtonTitles : [String] = []
        var bottomRowButtonTitles : [String] = []
        
        switch pageType {
        case PageType.Lowercase:
            firstRowButtonTitles = ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"]
            secondRowButtonTitles = ["A", "S", "D", "F", "G", "H", "J", "K", "L", "smart"]
            thirdRowButtonTitles = ["shiftDown", "Z", "X", "C", "V", "B", "N", "M", "backspace"]
            bottomRowButtonTitles = ["numeric", "nextkeyboard", "microphone", "space", "return"]
            break
        case PageType.Uppercase:
            firstRowButtonTitles = ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p"]
            secondRowButtonTitles = ["a", "s", "d", "f", "g", "h", "j", "k", "l", "smart"]
            thirdRowButtonTitles = ["shiftUp", "z", "x", "c", "v", "b", "n", "m", "backspace"]
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
    

    func createButtons(titles: [String], rowNumber: Int) {
        let screenSize : CGRect = UIScreen.mainScreen().bounds
        let screenWidth = screenSize.width
        
        var buttons = [CustomKey]()
    
        for title in titles {
            let button = LetterKey.buttonWithType(.Custom) as! LetterKey
            button.setTitle(title, forState: .Normal)
            button.setTranslatesAutoresizingMaskIntoConstraints(false)
            button.addTarget(self, action: "keyPressed:", forControlEvents: .TouchUpInside)
            buttons.append(button)
        }
        
        // Add the buttons and row of buttons to the keyboard
        var row = UIView(frame: CGRectMake(CGFloat(0), CGFloat(2 + (45 * (rowNumber - 1))), screenWidth, CGFloat(40)))
        for button in buttons {
            row.addSubview(button)
        }
        self.view.addSubview(row)
        addConstraints(buttons, containingView: row)
    }
    
    
    
    func keyPressed(sender: AnyObject?) {
        let button = sender as! UIButton
        let title = button.titleForState(.Normal)
        (textDocumentProxy as! UIKeyInput).insertText(title!)
    }
    
    
    
    func addConstraints(buttons: [UIButton], containingView: UIView){
        
        for (index, button) in enumerate(buttons) {
            
            var topConstraint = NSLayoutConstraint(item: button, attribute: .Top, relatedBy: .Equal, toItem: containingView, attribute: .Top, multiplier: 1.0, constant: 1)
            
            var bottomConstraint = NSLayoutConstraint(item: button, attribute: .Bottom, relatedBy: .Equal, toItem: containingView, attribute: .Bottom, multiplier: 1.0, constant: -1)
            
            var leftConstraint : NSLayoutConstraint!
            
            if index == 0 {
                
                leftConstraint = NSLayoutConstraint(item: button, attribute: .Left, relatedBy: .Equal, toItem: containingView, attribute: .Left, multiplier: 1.0, constant: 1)
                
            }else{
                
                leftConstraint = NSLayoutConstraint(item: button, attribute: .Left, relatedBy: .Equal, toItem: buttons[index-1], attribute: .Right, multiplier: 1.0, constant: 1)
                
                var widthConstraint = NSLayoutConstraint(item: buttons[0], attribute: .Width, relatedBy: .Equal, toItem: button, attribute: .Width, multiplier: 1.0, constant: 0)
                
                containingView.addConstraint(widthConstraint)
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
        self.nextKeyboardButton.setTitleColor(textColor, forState: .Normal)
    }
}
