//
//  UIImage+AGScaleAndCropImage.swift
//  Pods
//
//  Created by Michael Liptuga on 19.05.17.
//
//

import Foundation
import UIKit

public extension UIImage {
    
    public func scaleAndCropImage(_ image: UIImage, toSize newSize: CGSize) -> UIImage
    {
        if image.size.equalTo(newSize) || (image.size.height < newSize.height && image.size.width < newSize.width) {
            return image
        }
        // Find the ratios of the desired dimensions to the current dimensions,
        // and use the larger one to scale the image to fill the desired size
        let widthFactor = newSize.width / image.size.width
        let heightFactor = newSize.height / image.size.height
        let scaleFactor = max(widthFactor, heightFactor)
        
        let scaledSize = CGSize(width: image.size.width * scaleFactor,
                                height: image.size.height * scaleFactor)
        
        // Inset the origin to draw from so that the intersection of the new size and scaled size will be centered
        let drawingOrigin = CGPoint(x: (newSize.width - scaledSize.width) / 2.0,
                                    y: (newSize.height - scaledSize.height) / 2.0)
        
        let drawingRect = CGRect(origin: drawingOrigin,
                                 size: scaledSize)
        
        // Passing an image context scale of 0.0 results in a scale equal to the screen's scale
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: drawingRect)
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return scaledImage
    }
}
