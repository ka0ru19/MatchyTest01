//
//  String+Extension.swift
//  MatchyTest01
//
//  Created by 井上航 on 2016/09/07.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import Foundation

extension String {
    
    func calcDeadlineIntervalFromNow() -> NSTimeInterval {
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP")
        dateFormatter.dateFormat = "yyyy/MM/dd' 'HH:mm"
        let deadlineDate = dateFormatter.dateFromString(self)
        return deadlineDate!.timeIntervalSinceNow
    }
    
    func changeDateStringToNSDate() -> NSDate {
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP")
        dateFormatter.dateFormat = "yyyy/MM/dd' 'HH:mm"
        return dateFormatter.dateFromString(self)!
    }
    
}