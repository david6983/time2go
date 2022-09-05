//
//  datepicker.swift
//  time2go
//
//  Created by david6983 on 23/06/2022.
//

import SwiftUI

extension DatePicker {
    static func getRange(minHour: Int, maxHour: Int) -> ClosedRange<Date> {
        return Date.from(string: "\(String(minHour).paddingTime()):00")
                ...
                Date.from(string: "\(String(maxHour).paddingTime()):00")
    }
}
