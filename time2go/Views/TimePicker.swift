//
//  TimePicker.swift
//  time2go
//
//  Created by david6983 on 23/06/2022.
//

import SwiftUI

struct TimePicker: View {
    @Binding var selection: Date
    var text: String
    var range: ClosedRange<Date>
    var is24hFormat: Bool
    
    var body: some View {
        DatePicker(selection: $selection,
                   in: range,
                   displayedComponents: .hourAndMinute) {
            Text(text)
                .foregroundColor(Color.textContainer)
                .font(.textFont)
        }
        .environment(\.locale, Locale.init(identifier: self.getLocal()))
        .environment(\.timeZone, TimeZone.init(abbreviation: "UTC")!)
    }
    
    private func getLocal() -> String {
        if self.is24hFormat {
            return "fr_FR"
        }
        
        return "en_US"
    }
}

struct TimePicker_Previews: PreviewProvider {
    static var previews: some View {
        TimePicker(selection: .constant(Date.from(string: "08:50")), text: "😎 Arrived at:", range: DatePicker<Text>.getRange(minHour: 08, maxHour: 09), is24hFormat: true)
            .previewLayout(.sizeThatFits)
    }
}
