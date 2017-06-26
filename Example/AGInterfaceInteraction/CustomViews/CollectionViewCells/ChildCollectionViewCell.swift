//
//  ChildCollectionViewCell.swift
//  DynamicAnimations
//
//  Created by Michael Liptuga on 10.05.17.
//  Copyright © 2017 Agilie. All rights reserved.
//

import UIKit

class ChildCollectionViewCell: MainCollectionViewCell {

    @IBOutlet weak var childImageView: UIImageView!
    
    @IBOutlet weak var childNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutIfNeeded()
        self.updateConstraintsIfNeeded()
        self.childImageView.layer.cornerRadius = self.childImageView.bounds.height / 2
        self.childImageView.layer.masksToBounds = true
    }
    
    override class func cellSize () -> CGSize
    {
        return CGSize(width: 90.0, height : 130.0)
    }

    override func configureForObject(object: Any?)
    {
        guard let child = object as? ChildModel else {
            return
        }
        self.childNameLabel.text = child.name.capitalized
        
        let defaultColor = UIColor.init(red: 177.0/255.0,
                                        green: 183.0/255.0,
                                        blue: 192.0/255.0,
                                        alpha: 1.0)
        
        let selectedColor = UIColor.init(red: 88.0/255.0,
                                         green: 88.0/255.0,
                                         blue: 88.0/255.0,
                                         alpha: 1.0)
        
        self.childNameLabel.textColor = (self.childNameLabel.text == "Add") ? defaultColor : selectedColor
            
        self.childImageView.image = UIImage.init(named: child.avatarImageName)
    }
}
