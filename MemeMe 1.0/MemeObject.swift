//
//  MemeObject.swift
//  MemeMe 1.0
//
//  Created by Stephanie Bogart on 25/6/21.
//

import Foundation
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
}
