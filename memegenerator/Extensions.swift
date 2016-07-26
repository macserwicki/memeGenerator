//
//  Extensions.swift
//  memegenerator
//
//  Created by Maciej Serwicki on 7/25/16.
//  Copyright © 2016 Maciej Serwicki. All rights reserved.
//
import UIKit
import Foundation

extension UIImage {
    convenience init(view: UIView) {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0)
        view.drawViewHierarchyInRect(view.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        self.init(CGImage: image.CGImage!)
        UIGraphicsEndImageContext()
    }
}


