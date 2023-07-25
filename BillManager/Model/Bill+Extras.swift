//
//  Bill+Extras.swift
//  BillManager
//

import Foundation
import  UserNotifications

extension Bill {
    
    static let notificationCategoryID = "ReminderNotifications"
    
    var hasReminder: Bool {
        return (remindDate != nil)
    }
    
    var isPaid: Bool {
        return (paidDate != nil)
    }
    
    var formattedDueDate: String {
        let dateString: String
        
        if let dueDate = self.dueDate {
            dateString = dueDate.formatted(date: .numeric, time: .omitted)
        } else {
            dateString = ""
        }
        
        return dateString
    }
    
    
    func removeReminder() {
        
    }
    
    mutating func scheduleReminder(on date: Date , completion: @escaping (Bool) -> ()) {
        
    }
    
    
    private func authorizeIfNeeded(completion: @escaping (Bool)  -> ()) {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { (settings) in
            switch settings.authorizationStatus {
            case .authorized, . provisional:
                completion(true)
            case .notDetermined:
                notificationCenter.requestAuthorization(options: [.sound, .alert], completionHandler: { (granted, _) in
                    completion(granted)
                })
            case .ephemeral:
                // Only available to app clips
                completion(false)
            case . denied:
                completion(false)
            @unknown default:
                completion(false)
            }
        }
    }
    
    
}
