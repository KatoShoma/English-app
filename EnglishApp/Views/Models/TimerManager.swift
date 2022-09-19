//
//  TimerManager.swift
//  EnglishApp
//
//  Created by 加藤祥真 on 2022/08/31.
//

import Foundation
import SwiftUI

class TimerManager: ObservableObject {

    @Published var timeLabel: String = "----"
    @Published var time: Int = 60

    var timer = Timer()

    func start(studyTime: Int) {
        self.time = studyTime
        self.timeLabel = self.secondsToMinutesAndSeconds(seconds: time)

        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
            if self.time == 0 {
                timer.invalidate() // タイマーを停止してメモリを解放
                return
            }
            self.time -= 1
            self.timeLabel = self.secondsToMinutesAndSeconds(seconds: self.time) // 分:秒の形で指定
        })
    }

    func secondsToMinutesAndSeconds(seconds: Int) -> String {
        let minutes = "\((seconds % 3600) / 60)"
        let seconds = "\((seconds % 3600) % 60)"
        let minutesStamp = minutes.count > 1 ? minutes : "0" + minutes
        let secondStamp = seconds.count > 1 ? seconds : "0" + seconds

        return "\(minutesStamp) : \(secondStamp)"
    }
}
