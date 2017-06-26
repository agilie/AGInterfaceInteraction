//
//  TripOptionTableViewCell.swift
//  DynamicAnimations
//
//  Created by Michael Liptuga on 10.05.17.
//  Copyright © 2017 Agilie. All rights reserved.
//

import UIKit

class TripOptionTableViewCell: MainTableViewCell {
    
    @IBOutlet weak var collectionView: CustomCollectionView!
    
    var tripOptions : [TripOptionModel] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.collectionDataSource = self
        self.collectionView.collectionDelegate = self
    }
    
    override func configureForObject (object : Any?)
    {
        guard let tripOptionList = object as? [TripOptionModel] else {
            return
        }
        tripOptions = tripOptionList
    }
}

extension TripOptionTableViewCell : CustomCollectionViewDataSource
{
    func numberOfSections () -> Int
    {
        return 1
    }
    
    func numberOfItemsInSection (section : Int) -> Int
    {
        return tripOptions.count
    }
    
    func objectAtIndexPath (indexPath : IndexPath) -> Any?
    {
        if (tripOptions.count > indexPath.row) {
            return tripOptions[indexPath.row]
        }
        return nil
    }
    
    func collectionViewType () -> CustomCollectionViewType
    {
        return .optionTripType
    }
}

extension TripOptionTableViewCell : CustomCollectionViewDelegate
{
    func selectedObjectAtIndexPath (index : IndexPath)
    {
        if (self.tripOptions.count > index.row)
        {
            self.tripOptions[index.row].isChosen = !self.tripOptions[index.row].isChosen
            self.collectionView.reloadItems(at: [index])
        }
    }
    
}
