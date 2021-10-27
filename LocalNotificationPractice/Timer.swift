//
//  Timer.swift
//  LocalNotificationPractice
//
//  Created by 坂本龍哉 on 2021/10/26.
//

import Foundation

struct TimesManagement {
    var times: [Int]
    var startDate: Date
    var endDate: [Date] {
        times.enumerated().map {
            let time = times[0...$0.offset].reduce(0, +)
            return startDate.addingTimeInterval(TimeInterval(time))
        }
    }
    var currentIndex: Int {
        for a in endDate.enumerated() {
            if a.element > Date() {
                return a.offset
            }
        }
        return 0
    }
    var timeLeft: Int {
        return Int(endDate[currentIndex].timeIntervalSince1970 - Date().timeIntervalSince1970)
    }
    
    func isFinish(now: Date = Date()) -> Bool {
        print(now, endDate.last ?? Date())
        return now + 1 >= endDate.last ?? Date()
    }
    
}


final class CountDown {
    private var timer = Timer()
    var timesManagement: TimesManagement?
    var displayCount: (Int) -> Void = {_ in}
    
    init(counts: [Int]) {
        timesManagement = TimesManagement(times: counts, startDate: Date())
    }
    
    
    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 1,
                                     repeats: true,
                                     block: { timer in
            guard let timeManagement = self.timesManagement else { return }
            self.displayCount(timeManagement.timeLeft)
            print(timeManagement.timeLeft)
            if timeManagement.isFinish(now: Date()) {
                timer.invalidate()
            }
        })
    }
}
