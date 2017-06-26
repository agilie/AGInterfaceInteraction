//
//  MainCollectionViewCell.swift
//  DynamicAnimations
//
//  Created by Michael Liptuga on 10.05.17.
//  Copyright © 2017 Agilie. All rights reserved.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell, CellInterface {
    
    func configureForObject (object : Any?)
    {
        
    }
    
    class func cellSize () -> CGSize {
        return CGSize(width: 50, height: 50.0)
    }

}
