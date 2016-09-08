//
//  NSTimeInterval+Extension.swift
//  MatchyTest01
//
//  Created by 井上航 on 2016/09/07.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import Foundation

extension NSTimeInterval {
    
    func setLastTimeText() -> String {
        var lastTimeText = "設定なし"
        if self/60/60/24 > 1 {
            lastTimeText = "残り" + String(Int(self/60/60/24)) + "日"
        } else if self/60/60 > 1 {
            lastTimeText = "残り" + String(Int(self/60/60)) + "時間"
        } else if self/60 > 1 {
            lastTimeText = "残り" + String(Int(self/60)) + "分"
        } else {
            lastTimeText = "残り1分未満"
        }
        return lastTimeText
    }
    
}