//
//  TableViewItem.swift
//  DynamicAnimations
//
//  Created by Michael Liptuga on 10.05.17.
//  Copyright © 2017 Agilie. All rights reserved.
//

import Foundation
class TableViewItem : NSObject {
    
    var cellId           : String = ""
    var object           : Any?   = nil
    
    init(itemCellId : String, itemObject : Any?) {
        cellId = itemCellId
        object = itemObject
        super.init()
    }
}



