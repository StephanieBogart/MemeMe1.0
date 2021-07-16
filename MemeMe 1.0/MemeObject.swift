//
//  MemeObject.swift
//  MemeMe 1.0
//
//  Created by Stephanie Bogart on 25/6/21.
//

import UIKit

struct Meme {
    var topText: String
    var bottomText: String
    var originalImage: UIImage
    var memedImage: UIImage
    
    func save() {
        let meme = Meme(topText: topText,
                        bottomText: bottomText,
                        originalImage: originalImage,
                        memedImage: memedImage)
    }
    
//    func generateMemedImage() -> UIImage {
//        // TODO: Hide toolbar and navbar
//        
//        // Render view to an image
//        UIGraphicsBeginImageContext(self.view.frame.size)
//        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
//        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
//        UIGraphicsEndImageContext()
//        
//        // TODO: Show toolbar and navbar
//        
//        return memedImage
//    }
}
