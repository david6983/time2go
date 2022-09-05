//
//  ContentView.swift
//  time2go
//
//  Created by david6983 on 14/06/2022.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("morningIn") var morningIn = Date.from(string: "08:50")
    @AppStorage("morningOut") var morningOut = Date.from(string: "12:10")
    @AppStorage("afternoonIn") var afternoonIn = Date.from(string: "13:10")
    @AppStorage("afternoonOut") var afternoonOut = Date.from(string: "17:30")
    @AppStorage("workingTime") var workingTime = Date.from(string: "07:30")
    @State private var showingNotificationSetAlert = false
    var calendar = Calendar.current
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.background
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            VStack {
                VStack {
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                    Text("It's time to go")
                        .font(.textFontBig)
                        .foregroundColor(Color.bigText)
                }
                .padding(.top, 70)
                
                VStack {
                    TimePicker(selection: $workingTime, text: "⚙️ Number of working hours:", range: DatePicker<Text>.getRange(minHour: 06, maxHour: 08), is24hFormat: true)
                    TimePicker(selection: $morningIn, text: "😎 Arrived at:", range: DatePicker<Text>.getRange(minHour: 08, maxHour: 09), is24hFormat: true)
                        .padding(.top)
                    TimePicker(selection: $morningOut, text: "🍔 Time to eat: ", range: DatePicker<Text>.getRange(minHour: 11, maxHour: 13), is24hFormat: true)
                        .padding(.top)
                    TimePicker(selection: $afternoonIn, text: "🥱 Started back at: ", range: DatePicker<Text>.getRange(minHour: 12, maxHour: 14), is24hFormat: true)
                        .padding(.top)
                }
                .padding()
                .background(Color.container)
                .cornerRadius(15)
                .padding()
                
                Text("You can leave at 🥳")
                    .font(Font.textFontBigBold)
                    .foregroundColor(Color.bigText)
                    .padding()
                
                VStack {
                    Button(action: {
                        showingNotificationSetAlert = true
                        
                        let content = UNMutableNotificationContent()
                        content.title = "It's time to Go"
                        content.subtitle = "You did a great job 💪😄 !"
                        content.sound = UNNotificationSound.default

                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "HH:mm"
                        dateFormatter.timeZone = calendar.timeZone
                        
                        let now = Date.from(string: dateFormatter.string(from: Date.now))
                        let leave = getAfternoonOut()
                        let interval = ((leave.hour() - now.hour()) * 3600) + ((leave.minute() - now.minute()) * 60)
                        print("Notification trigged at \(leave.toString()) from \(now.toString()) which is \(interval) seconds of interval")
                        // show this notification five seconds from now
                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(interval), repeats: false)

                        // choose a random identifier
                        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                        // add our notification request
                        UNUserNotificationCenter.current().add(request)
                    }) {
                        Text("\(getAfternoonOut().toString())")
                            .font(Font.hour)
                            .foregroundColor(Color.textContainer)
                            .padding()
                    }
                    .alert("Notification reminder set at \(getAfternoonOut().toString())", isPresented: $showingNotificationSetAlert) {
                        Button("OK", role: .cancel) { }
                    }
                }
                .background(Color.container)
                .cornerRadius(15)
            }
        }
        .ignoresSafeArea()
    }
    
    func getAfternoonOut() -> Date {
        let morningOffset = morningOut - morningIn
        let toAdd = workingTime - morningOffset
        return afternoonIn + toAdd
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
