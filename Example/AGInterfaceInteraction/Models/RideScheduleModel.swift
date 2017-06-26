//
//  RideScheduleModel.swift
//  DynamicAnimations
//
//  Created by Michael Liptuga on 10.05.17.
//  Copyright © 2017 Agilie. All rights reserved.
//

import Foundation


class RideScheduleModel : NSObject {
    
    var departurePoint      : String = ""
    var destination         : String = ""
    var departureDate       : Date? = nil
    
    var childrenList    : [ChildModel]      = []
    var tripOptionList  : [TripOptionModel] = []

    var departurePointStruct : ScheduleItemStruct {
        get {
            return ScheduleItemStruct.init(type: .departurePointType, rideScheduleModel : self)
        }
    }
    
    var destinationStruct : ScheduleItemStruct {
        get {
            return ScheduleItemStruct.init(type: .destinationType, rideScheduleModel : self)
        }
    }

    var departureDateStruct : ScheduleItemStruct {
        get {
            return ScheduleItemStruct.init(type: .departureDateType, rideScheduleModel : self)
        }
    }
    
    override init() {
        super.init()
    }
}


struct ScheduleItemStruct {
    
    var iconName            : String = ""
    var titleName           : String = ""
    var type                : ScheduleItemType = .departurePointType
    var date                : Date? = nil
    var scheduleDescription : String = ""
    
    init(type : ScheduleItemType, rideScheduleModel : RideScheduleModel) {
        self.type = type
        switch type {
        case .departurePointType:
            self.iconName = "scheduleDeparturePoint_icon"
            self.titleName = "from"
            self.scheduleDescription = rideScheduleModel.departurePoint
            break
        case .destinationType:
            self.iconName = "scheduleDestination_icon"
            self.titleName = "to"
            self.scheduleDescription = rideScheduleModel.destination
            break
        default:
            self.iconName = "scheduleDepartureDate_icon"
            self.titleName = "time"
            self.date = rideScheduleModel.departureDate
            break
        }
    }
}

