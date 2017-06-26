//
//  TripOptionCollectionViewCell.swift
//  DynamicAnimations
//
//  Created by Michael Liptuga on 10.05.17.
//  Copyright © 2017 Agilie. All rights reserved.
//

import UIKit

class TripOptionCollectionViewCell: MainCollectionViewCell {

    @IBOutlet weak var optionBackgroundView: UIView!
    
    @IBOutlet weak var optionImageView: UIImageView!
    
    @IBOutlet weak var optionNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutIfNeeded()
        self.updateConstraintsIfNeeded()
        
        self.optionBackgroundView.layer.cornerRadius = 10.0
        
        self.optionBackgroundView.layer.borderColor = UIColor.init(rgbColorCodeRed  : 217,
                                                                   green            : 221,
                                                                   blue             : 228,
                                                                   alpha            : 1.0).cgColor
        self.optionBackgroundView.layer.borderWidth = 0.5
        
        self.optionBackgroundView.layer.masksToBounds = true
    }
    
    override class func cellSize () -> CGSize
    {
        return CGSize(width: 133.0, height : 164.0)
    }
    
    override func configureForObject(object: Any?)
    {
        guard let tripOption = object as? TripOptionModel else {
            return
        }
        self.optionNameLabel.text = tripOption.optionName.capitalized
        
        self.optionNameLabel.textColor = self.optionNameLabelTextColor(isSelected: tripOption.isChosen)

        self.optionBackgroundView.backgroundColor = self.optionBackgroundViewColor(isSelected: tripOption.isChosen)
        
        self.optionImageView.image =  UIImage.init(named: (tripOption.isChosen) ? tripOption.selectedImageName : tripOption.defaultImageName)
        
    }
}

extension TripOptionCollectionViewCell
{
    func optionNameLabelTextColor (isSelected : Bool) -> UIColor
    {
        let selectedColor = UIColor.init(rgbColorCodeRed: 88, green: 96, blue: 119, alpha: 1.0)
        
        let defaultColor = UIColor.init(rgbColorCodeRed: 135, green: 143, blue: 157, alpha: 0.61)
        
        return isSelected ? selectedColor : defaultColor
    }
    
    func optionBackgroundViewColor (isSelected : Bool) -> UIColor
    {
        let selectedColor = UIColor.init(rgbColorCodeRed: 252, green: 253, blue: 254, alpha: 1.0)

        let defaultColor = UIColor.init(rgbColorCodeRed: 248, green: 250, blue: 252, alpha: 1.0)
        
        return isSelected ? selectedColor : defaultColor
    }

}
