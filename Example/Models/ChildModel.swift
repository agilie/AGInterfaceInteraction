//
//  ChildModel.swift
//  DynamicAnimations
//
//  Created by Michael Liptuga on 10.05.17.
//  Copyright © 2017 Agilie. All rights reserved.
//

import Foundation

class ChildModel : NSObject {
    
    var name                : String = ""
    var avatarImageName     : String = ""
    
    init(childName : String, childAvatarImageName : String) {
        name = childName
        avatarImageName = childAvatarImageName
        super.init()
    }    
}


