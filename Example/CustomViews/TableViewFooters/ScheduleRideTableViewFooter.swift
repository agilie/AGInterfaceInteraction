//
//  ScheduleRideTableViewFooter.swift
//  AGGravityServiceExample
//
//  Created by Michael Liptuga on 16.05.17.
//  Copyright © 2017 Agilie. All rights reserved.
//

import UIKit

class ScheduleRideTableViewFooter: UIView {

    @IBOutlet weak var priceButton: UIButton!
    
    class func create () -> ScheduleRideTableViewFooter
    {
        let nibName = String.init(describing: self)
        let nibObjects =  Bundle.main.loadNibNamed(nibName, owner: self, options: nil)
        let footer = nibObjects!.first as! ScheduleRideTableViewFooter
        
        footer.configurePriceButton()
        footer.frame.size = footer.size()
        
        return footer
    }
}

extension ScheduleRideTableViewFooter
{
    fileprivate func size () -> CGSize
    {
        return CGSize(width : UIScreen.main.bounds.width, height : 74)
    }

    fileprivate func configurePriceButton()
    {
        self.priceButton.layer.cornerRadius = self.priceButton.frame.height / 2
        self.priceButton.layer.masksToBounds = true
        self.priceButton.backgroundColor = UIColor.init(rgbColorCodeRed: 0, green: 202, blue: 255, alpha: 1.0)
    }
}
