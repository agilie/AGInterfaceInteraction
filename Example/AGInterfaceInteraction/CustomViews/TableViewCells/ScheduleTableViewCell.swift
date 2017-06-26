//
//  ScheduleTableViewCell.swift
//  DynamicAnimations
//
//  Created by Michael Liptuga on 10.05.17.
//  Copyright © 2017 Agilie. All rights reserved.
//

import UIKit

class ScheduleTableViewCell: MainTableViewCell {

    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var scheduleDescriptionLabel: UILabel!
    
    override func configureForObject (object : Any?)
    {
        guard let scheduleItem = object as? ScheduleItemStruct else {
            return
        }
        
        self.iconImageView.image = UIImage.init(named: scheduleItem.iconName)
        self.titleLabel.text = scheduleItem.titleName.uppercased()
        self.configureScheduleDescriptionLabelFor(scheduleItem: scheduleItem)
    }
}

extension ScheduleTableViewCell
{
    fileprivate func configureScheduleDescriptionLabelFor (scheduleItem : ScheduleItemStruct)
    {
        switch scheduleItem.type {
        case .departurePointType, .destinationType:
            self.scheduleDescriptionLabel.text = scheduleItem.scheduleDescription
            break
        default:
            self.scheduleDescriptionLabel.text = Date.twelveHourTimeFormat(date: scheduleItem.date)
            break
        }
    }
}
