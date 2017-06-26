//
//  Date+TwelveHourTimeFormat.swift
//  AGGravityServiceExample
//
//  Created by Michael Liptuga on 17.05.17.
//  Copyright © 2017 Agilie. All rights reserved.
//

import Foundation

extension Date {
    
    static func twelveHourTimeFormat (date : Date?) -> String {
        guard let currentDate = date else {
            return ""
        }
        let formatter = DateFormatter()
            formatter.dateFormat = "h:mm a 'on' dd/MM/yyyy"
            formatter.amSymbol = "AM"
            formatter.pmSymbol = "PM"
        
        return formatter.string(from: currentDate)
    }

}
