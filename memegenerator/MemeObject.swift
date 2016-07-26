//
//  MemeObject.swift
//  memegenerator
//
//  Created by Maciej Serwicki on 7/25/16.
//  Copyright © 2016 Maciej Serwicki. All rights reserved.
//

import UIKit

class MemeObject: NSObject {
        var topText: String
        var bottomText: String
        var image: UIImage
        var memedImage: UIImage?
        var scaledCroppedImage: UIImage?
        
        init(topText: String, bottomText: String, image: UIImage) {
            self.topText = topText
            self.bottomText = bottomText
            self.image = image
            self.memedImage = image
        }
    
}
