import SwiftUI
import UserNotifications

@main
struct time2goApp: App {
    init() {
        // Ask the user the permission to use notifications
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("Notifications permissions granted")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
