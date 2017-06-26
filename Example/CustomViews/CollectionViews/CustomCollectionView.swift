//
//  CustomCollectionView.swift
//  DynamicAnimations
//
//  Created by Michael Liptuga on 10.05.17.
//  Copyright © 2017 Agilie. All rights reserved.
//

import UIKit

protocol CustomCollectionViewDataSource : class {
    func numberOfSections () -> Int
    func numberOfItemsInSection (section : Int) -> Int
    func objectAtIndexPath (indexPath : IndexPath) -> Any?
    func collectionViewType () -> CustomCollectionViewType
}

protocol CustomCollectionViewDelegate : class {
    func selectedObjectAtIndexPath (index : IndexPath)
}

class CustomCollectionView: UICollectionView {
    
    weak var collectionDataSource : CustomCollectionViewDataSource?
    weak var collectionDelegate : CustomCollectionViewDelegate?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func awakeFromNib() {
        self.dataSource = self
        self.delegate = self
        self.setupCollectionView()
    }
}

extension CustomCollectionView : UICollectionViewDataSource {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.collectionDataSource?.numberOfSections() ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.collectionDataSource?.numberOfItemsInSection(section: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellIdentifier = self.cellIdentifier()
        
        if let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: cellIdentifier,
            for: indexPath
            ) as? MainCollectionViewCell {
            
            if let object = self.collectionDataSource?.objectAtIndexPath(indexPath: indexPath) {
                cell.configureForObject(object: object)
            }
            return cell
        }
        return UICollectionViewCell()
    }
}

extension CustomCollectionView : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.collectionDelegate?.selectedObjectAtIndexPath(index: indexPath)
    }
}

extension CustomCollectionView : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let currentType = self.collectionDataSource?.collectionViewType()  else {
            return MainCollectionViewCell.cellSize()
        }
        switch currentType {
        case .childrenType:
            return ChildCollectionViewCell.cellSize()
        default:
            return TripOptionCollectionViewCell.cellSize()
        }
    }
}

//MARK: Private methods

extension CustomCollectionView {
    
    fileprivate func setupCollectionView () {
        self.allowsMultipleSelection = false
        self.contentInset = UIEdgeInsetsMake(0, 10, 0, 10)
        self.register(UINib(nibName: ChildCollectionViewCell.id, bundle: Bundle.main), forCellWithReuseIdentifier: ChildCollectionViewCell.id)
        self.register(UINib(nibName: TripOptionCollectionViewCell.id, bundle: Bundle.main), forCellWithReuseIdentifier: TripOptionCollectionViewCell.id)
    }
    
    fileprivate func cellIdentifier () -> String
    {
        guard let currentType = self.collectionDataSource?.collectionViewType()  else {
            return ""
        }
        switch currentType {
        case .childrenType:
            return ChildCollectionViewCell.id
        default:
            return TripOptionCollectionViewCell.id
        }
    }
    
}


