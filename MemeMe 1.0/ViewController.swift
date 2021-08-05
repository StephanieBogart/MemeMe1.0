//
//  ViewController.swift
//  MemeMe 1.0
//
//  Created by Stephanie Bogart on 20/6/21.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    // MARK: Properties
    let memeText = MemeTextDelegate()
    
    // MARK: Outlets
    @IBOutlet weak var bottomToolBar: UIToolbar!
    @IBOutlet weak var pickImageButton: UIBarButtonItem!
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var topToolBar: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up Meme placeholder content
        topTextField.delegate = memeText
        bottomTextField.delegate = memeText
        memeText.setStyle(textField: topTextField, position: .Top)
        memeText.setStyle(textField: bottomTextField, position: .Bottom)
        
        // Set up top and bottom bars
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        topToolBar.items = [shareButton, flexibleSpace]
        bottomToolBar.items = [flexibleSpace, pickImageButton, cameraButton, flexibleSpace]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        subscribeToKeyboardShowNotifs()
        subscribeToKeyboardHideNotifs()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }

    // MARK: - Actions
    @IBAction func pickAlbumImage(_ sender: UIBarButtonItem) {
        pickImage(.savedPhotosAlbum)
    }
    
    @IBAction func pickCameraImage(_ sender: UIBarButtonItem) {
        pickImage(.camera)
    }
    
    @IBAction func shareMeme(_ sender: UIBarButtonItem) {
        let memeImage = [generateMemedImage()]
        let activityViewController = UIActivityViewController(activityItems: memeImage, applicationActivities: nil)
        present(activityViewController, animated: true)
    }
    
    func pickImage(_ imageSourceType: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = imageSourceType
        present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - Controllers
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imagePickerView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Keyboard Delegate
    @objc func keyboardWillShow(_ notification: Notification) {
        if bottomTextField.isFirstResponder {
            bottomConstraint.constant = -getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        if bottomConstraint.constant != 0 {
            bottomConstraint.constant = 0
        }
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardShowNotifs() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    func subscribeToKeyboardHideNotifs() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func generateMemedImage() -> UIImage {
        // Prep the UI to share an image
        toggleUIToolbars(show: false)

        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // Restore the toolbars after screenshot taken
        toggleUIToolbars(show: true)
        return memedImage
    }
    
    func toggleUIToolbars(show: Bool) {
        if !show {
            topToolBar.isHidden = true
            bottomToolBar.isHidden = true
        } else {
            topToolBar.isHidden = false
            bottomToolBar.isHidden = false
        }
    }
}

