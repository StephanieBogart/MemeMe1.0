//
//  KeyboardDelegate.swift
//  MemeMe 1.0
//
//  Created by Stephanie Bogart on 25/6/21.
//

import UIKit

class KeyboardDelegate: UIViewController, UINavigationControllerDelegate {
    

    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardShowNotifs() {
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController().keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    func subscribeToKeyboardHideNotifs() {
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController().keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
