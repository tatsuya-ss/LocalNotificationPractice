//
//  ViewController.swift
//  LocalNotificationPractice
//
//  Created by 坂本龍哉 on 2021/10/17.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet private weak var firstTimeTextField: UITextField!
    @IBOutlet private weak var secondTimeTextField: UITextField!
    @IBOutlet private weak var thirdTimeTextField: UITextField!
    @IBOutlet private weak var displayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocalNotification()
    }
    
    @IBAction private func setTimerButtonDidTap(_ sender: Any) {
        guard let firstTime = firstTimeTextField.text,
        let secondTime = secondTimeTextField.text,
        let thirdTime = thirdTimeTextField.text else { return }
        let times = [firstTime, secondTime, thirdTime].map { Int($0) ?? 0 }
        let countDown = CountDown(counts: times)
        countDown.displayCount = { time in
            self.displayLabel.text = String(time)
        }
        times.enumerated()
            .forEach {
                let time = times[0...$0.offset].reduce(0, +)
                setTime(time: time)
            }
        countDown.start()
    }
    
}

// MARK: - 何秒後か指定
extension ViewController {
    
    private func setTime(time: Int) {
        let content = makeNotificationContent()
        let trigger = makeTimeIntervalNotificationTrigger(time: time)
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
    
    private func makeTimeIntervalNotificationTrigger(time: Int) -> UNTimeIntervalNotificationTrigger {
        UNTimeIntervalNotificationTrigger(
            timeInterval: TimeInterval(time),
            repeats: false
        )
    }
    
    private func makeNotificationRequest(content: UNMutableNotificationContent,
                                         trigger: UNTimeIntervalNotificationTrigger) -> UNNotificationRequest {
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString,
                                            content: content,
                                            trigger: trigger)
        return request
    }

}

// MARK: - 時間指定
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
