//
//  ViewController.swift
//  LocalNotificationPractice
//
//  Created by 坂本龍哉 on 2021/10/17.
//

import UIKit

final class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocalNotification()
    }

}

extension ViewController {
    
    private func setupLocalNotification() {
        let content = makeNotificationContent()
        let trigger = makeNotificationTrigger()
        let request = makeNotificationRequest(content: content, trigger: trigger)
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { error in
            if let error = error {
                print(error)
            } else {
                print("通知設定完了")
            }
        }
    }
    
    private func makeNotificationContent() -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = "初のローカル通知！"
        content.body = "成功してるかな〜"
        return content
    }
    
    private func makeNotificationTrigger() -> UNCalendarNotificationTrigger {
        var dateComponents = DateComponents()
        dateComponents.calendar = .current
        
        dateComponents.year = 2021
        dateComponents.month = 10
        dateComponents.day = 17
        dateComponents.hour = 21
        dateComponents.minute = 7
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        return trigger
    }
    
    private func makeNotificationRequest(content: UNMutableNotificationContent,
                             trigger: UNCalendarNotificationTrigger) -> UNNotificationRequest {
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString,
                                            content: content,
                                            trigger: trigger)
        return request
    }
    
}
