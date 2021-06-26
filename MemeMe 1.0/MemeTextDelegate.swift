//
//  MemeTextDelegate.swift
//  MemeMe 1.0
//
//  Created by Stephanie Bogart on 25/6/21.
//

import UIKit

class MemeTextDelegate: UIViewController, UITextFieldDelegate {


    
    
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.backgroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name:"HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth: 1.0
    ]
    
    enum Position: String {
        case Top, Bottom
    }
    
    func setStyle(textField: UITextField, position: Position) {
        
        switch position {
        case .Top:
            textField.text = "TOP"
        case .Bottom:
            textField.text = "BOTTOM"
        }
        
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .center
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "TOP" || textField.text == "BOTTOM" {
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
