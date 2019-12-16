//
//  Date_Exctension.swift
//  WaffleHouseSearch
//
//  Created by dirtbag on 12/15/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

import Foundation

extension Date {

    func getWeekday() -> Int {
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: self)
        return weekDay
    }

    func getYelpWeekday() -> Int {
        return (getWeekday() + 5) % 7
    }
}
