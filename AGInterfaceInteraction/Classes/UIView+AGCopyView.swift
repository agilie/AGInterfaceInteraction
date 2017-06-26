//
//  UIView+AGCopyView.swift
//  Pods
//
//  Created by Michael Liptuga on 19.05.17.
//
//

import UIKit

public extension UIView
{
    public func copyView (origin : CGPoint) -> UIView?
    {
        if let copyView = NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: self)) as? UIView
        {
            self.copyViewProperty(copyView: copyView)
            self.copyViewLayer(copyView: copyView)
            copyView.isHidden = false
            copyView.frame.origin = origin
            return copyView
        }
        return nil
    }
    
    
    fileprivate func copyViewProperty (copyView : UIView)
    {
        switch copyView {
        case is UIImageView:
            self.copyImageViewPropertiesFor(view: copyView)
        case is UITextView:
            self.copyTextViewPropertiesFor(view: copyView)
        default:
            return
        }
    }
    
    fileprivate func copyTextViewPropertiesFor(view: UIView)
    {
        if (((self as? UITextView) != nil) && ((view as? UITextView) != nil))
        {
            let textView = self as! UITextView
            let copyTextView = view as! UITextView
                copyTextView.isEditable = textView.isEditable
                copyTextView.isSelectable = textView.isSelectable
                copyTextView.isSecureTextEntry = textView.isSecureTextEntry
                copyTextView.isScrollEnabled = textView.isScrollEnabled
                copyTextView.textContainerInset = textView.textContainerInset
        }
    }
    
    fileprivate func copyImageViewPropertiesFor (view : UIView)
    {
        if (((self as? UIImageView) != nil) && ((view as? UIImageView) != nil))
        {
            let imageView = self as! UIImageView
            let copyImageView = view as! UIImageView
            
            if let image = imageView.image {
                copyImageView.contentMode = imageView.contentMode
                let scaledImage = UIImage.init(cgImage: image.cgImage!, scale: image.scale, orientation: image.imageOrientation)
                let data = NSKeyedArchiver.archivedData(withRootObject: scaledImage)
                if let copyImage = NSKeyedUnarchiver.unarchiveObject(with: data) as? UIImage {
                    copyImageView.image = UIImage().scaleAndCropImage(copyImage, toSize: copyImageView.frame.size)
                }
            }
        }
    }
    
    fileprivate func copyViewLayer (copyView : UIView)
    {
        let layer = self.layer
        
        copyView.layer.transform = layer.transform
        copyView.layer.allowsGroupOpacity = layer.allowsGroupOpacity
        copyView.layer.filters = layer.filters
        copyView.layer.compositingFilter = layer.compositingFilter
        copyView.layer.backgroundFilters = layer.backgroundFilters
        copyView.layer.shouldRasterize = layer.shouldRasterize
        copyView.layer.rasterizationScale = layer.rasterizationScale
        copyView.layer.mask = layer.mask
        copyView.layer.isOpaque = layer.isOpaque
        copyView.layer.contentsScale = layer.contentsScale
        copyView.layer.backgroundColor = layer.backgroundColor
        copyView.layer.cornerRadius = layer.cornerRadius
        copyView.layer.borderColor = layer.borderColor
        copyView.layer.borderWidth = layer.borderWidth
        copyView.layer.opacity = layer.opacity
        copyView.layer.masksToBounds = layer.masksToBounds
        copyView.layer.shadowPath = layer.shadowPath
        copyView.layer.shadowColor = layer.shadowColor
        copyView.layer.shadowOffset = layer.shadowOffset
        copyView.layer.shadowRadius = layer.shadowRadius
        copyView.layer.shadowOpacity = layer.shadowOpacity
    }
}


