//
//  ScheduleRideService.swift
//  DynamicAnimations
//
//  Created by Michael Liptuga on 12.05.17.
//  Copyright © 2017 Agilie. All rights reserved.
//

import Foundation

class ScheduleRideService : NSObject
{
    func loadScheduleRideDataWithCompletion ( completion : (_ scheduleRideData : [TableViewItem]) -> Void)
    {
        let rideSchedule = self.createRideScheduleExample()
        
        let tableViewData : [TableViewItem] = [
                                               TableViewItem.init(itemCellId: ChildrenTableViewCell.id,
                                                                  itemObject: rideSchedule.childrenList),
                                               TableViewItem.init(itemCellId: ScheduleTableViewCell.id,
                                                                  itemObject: rideSchedule.departurePointStruct),
                                               TableViewItem.init(itemCellId: ScheduleTableViewCell.id,
                                                                  itemObject: rideSchedule.destinationStruct),
                                               TableViewItem.init(itemCellId: ScheduleTableViewCell.id,
                                                                  itemObject: rideSchedule.departureDateStruct),
                                               TableViewItem.init(itemCellId: TripOptionTableViewCell.id,
                                                                  itemObject: rideSchedule.tripOptionList)]
        completion(tableViewData)
    }
    
    fileprivate func createRideScheduleExample () -> RideScheduleModel
    {
        let rideSchedule = RideScheduleModel.init()
        
        rideSchedule.departurePoint = "263 Maggio Haven"
        rideSchedule.destination = "43 Russel Forks"
        rideSchedule.departureDate = Date()
        
        rideSchedule.childrenList = [ChildModel.init(childName: "Olivia", childAvatarImageName: "Olivia_image"),
                                     ChildModel.init(childName: "John", childAvatarImageName: "John_image"),
                                     ChildModel.init(childName: "Add", childAvatarImageName: "Add_image")]
        
        rideSchedule.tripOptionList = [TripOptionModel.init(type: .luggageType),
                                       TripOptionModel.init(type: .petsType),
                                       TripOptionModel.init(type: .wheelchairType),
                                       TripOptionModel.init(type: .babyCarSeatType),]
        return rideSchedule
    }
}
