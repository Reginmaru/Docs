//
//  NotificationManager.swift
//  Docs
//
//  Created by Regin Maru on 12/05/2024.
//

import Foundation
import UserNotifications
import SwiftUI

class NotificationManager {
    static let shared = NotificationManager()
    var isAuthed: Bool = false
    
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if granted {
                print("granted")
                self.isAuthed = true
                completion(true)
            } else {
                print("not granted")
                completion(false)
            }
        }
    }

    func removeNotifications() -> Void {
        let center = UNUserNotificationCenter.current();
        center.removeAllDeliveredNotifications()
        center.removeAllPendingNotificationRequests()
        center.setBadgeCount(0)
    }
    
    func test() {
        // Create a notification content
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = "Don't forget to complete your tasks!"
        content.sound = .default
        
        // Create a notification trigger
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        // Create a notification request
        let request = UNNotificationRequest(identifier: "reminderNotification", content: content, trigger: trigger)
        
        // Add an action button
        let action = UNNotificationAction(identifier: "completeAction", title: "Complete", options: [])
        let category = UNNotificationCategory(identifier: "reminderCategory", actions: [action], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
        
        // Schedule the notification
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled successfully")
            }
        }
    }
    func scheduleNotificationForSpecificDate(cal: Calendar) {
        let content = UNMutableNotificationContent()
        content.title = "First Notification!"
        content.body = "Click me!"
        content.sound = UNNotificationSound.default
        
        // Set up date components
        let dateComponents = DateComponents(calendar: cal)
        // Create a calendar trigger for the specific date and time
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        // Generate a unique identifier for the notification request
        let requestIdentifier = UUID().uuidString
        
        // Create the notification request
        let request = UNNotificationRequest(identifier: requestIdentifier, content: content, trigger: trigger)
        
        // Add the notification request
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Error scheduling notification: \(error)")
            } else {
                print("Notification scheduled successfully")
            }
        }
    }
}

func Notification() -> Item {
    let title: String =  "Notications"
    let desc: AnyView = AnyView(
        ScrollView {
            VStack {
                Text("In the Docs, it says you should only ask for permission for notifications as late as you can.")
                    .doc()
                
                Button(action: {
                    NotificationManager.shared.requestAuthorization(completion: { c in
                        if(c){
                            NotificationManager.shared.test()
                        }
                    })
                }){
                    Image("notification")
                        .resizable()
                        .frame(width:24, height:24)
                    
                }
            }
        }.onAppear {
            NotificationManager.shared.removeNotifications()
        }
    )
    return Item(title: title, desc: desc)
}

#Preview {
    Notification().desc
}
