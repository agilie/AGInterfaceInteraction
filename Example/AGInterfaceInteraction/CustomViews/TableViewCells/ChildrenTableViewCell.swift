//
//  ChildrenTableViewCell.swift
//  DynamicAnimations
//
//  Created by Michael Liptuga on 10.05.17.
//  Copyright © 2017 Agilie. All rights reserved.
//

import UIKit

class ChildrenTableViewCell: MainTableViewCell {

    @IBOutlet weak var collectionView: CustomCollectionView!
    
    var children : [ChildModel] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.collectionDataSource = self
    }
    
    override func configureForObject (object : Any?)
    {
        guard let childrenList = object as? [ChildModel] else {
            return
        }
        children = childrenList
    }
}

extension ChildrenTableViewCell : CustomCollectionViewDataSource
{
    func numberOfSections () -> Int
    {
        return 1
    }
    
    func numberOfItemsInSection (section : Int) -> Int
    {
        return children.count
    }
    
    func objectAtIndexPath (indexPath : IndexPath) -> Any?
    {
        if (children.count > indexPath.row) {
            return children[indexPath.row]
        }
        return nil
    }
    
    func collectionViewType () -> CustomCollectionViewType
    {
        return .childrenType
    }
}
