//
//  TripOptionModel.swift
//  DynamicAnimations
//
//  Created by Michael Liptuga on 10.05.17.
//  Copyright © 2017 Agilie. All rights reserved.
//

import Foundation

class TripOptionModel : NSObject {
    
    var optionName          : String = ""
    var selectedImageName   : String = ""
    var defaultImageName    : String = ""
    var isChosen            : Bool   = false
    var currentType         : TripOptionModelType = .luggageType
    
    
    init(type : TripOptionModelType) {

        currentType = type

        switch type {
        case .luggageType:
            optionName = "luggage"
            selectedImageName = "luggageSelected_icon"
            defaultImageName = "luggageDefault_icon"
            break
        case .petsType:
            optionName = "pets"
            selectedImageName = "petsSelected_icon"
            defaultImageName = "petsDefault_icon"
            break
        case .wheelchairType:
            optionName = "wheelchair"
            selectedImageName = "wheelchairSelected_icon"
            defaultImageName = "wheelchairDefault_icon"
            break
        default:
            optionName = "baby car seat"
            selectedImageName = "babyCarSeatSelected_icon"
            defaultImageName = "babyCarSeatDefault_icon"
            break
        }
        
        super.init()
    }
}
