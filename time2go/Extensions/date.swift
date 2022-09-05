//
//  date.swift
//  time2go
//
//  Created by david6983 on 18/06/2022.
//

import SwiftUI
import Foundation

extension Date {
    static func from(string: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = TimeZone.init(abbreviation: "UTC")
        return dateFormatter.date(from: string)!
    }
    
    func hour() -> Int {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.init(abbreviation: "UTC")!
        return calendar.dateComponents([.hour], from: self).hour!
    }
    
    func minute() -> Int {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.init(abbreviation: "UTC")!
        return calendar.dateComponents([.minute], from: self).minute!
    }
        
    static func - (lhs: Date, rhs: Date) -> Date {
        let h1 = lhs.hour(); let m1 = lhs.minute()
        let h2 = rhs.hour(); let m2 = rhs.minute()
        
        // convert hours minutes => minutes
        let mTotal1 = h1*60+m1;
        let mTotal2 = h2*60+m2;
         
        // compute the difference
        let diff = mTotal1-mTotal2;
         
        // separate minutes and hours
        let diffH = diff/60;
        let diffM = diff%60;

        return Date.from(string: "\(String(diffH).paddingTime()):\(String(diffM).paddingTime())")
    }
    
    static func + (lhs: Date, rhs: Date) -> Date {
        let h1 = lhs.hour(); let m1 = lhs.minute()
        let h2 = rhs.hour(); let m2 = rhs.minute()
        
        // convert hours minutes => minutes
        let mTotal1 = h1*60+m1; // 770
        let mTotal2 = h2*60+m2; // 239
         
        // compute the difference
        let diff = mTotal1+mTotal2;
         
        // separate minutes and hours
        let diffH = diff/60;
        let diffM = diff%60;

        return Date.from(string: "\(String(diffH).paddingTime()):\(String(diffM).paddingTime())")
    }
    
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = TimeZone.init(abbreviation: "UTC")

        return dateFormatter.string(from: self)
    }
}

extension Date: RawRepresentable {
    private static let formatter = ISO8601DateFormatter()
    
    public var rawValue: String {
        Date.formatter.string(from: self)
    }
    
    public init?(rawValue: String) {
        self = Date.formatter.date(from: rawValue) ?? Date()
    }
}

extension String {
    func paddingTime() -> String {
        return self.count == 1 ? "0\(self)" : self
    }
}
