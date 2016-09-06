//
//  StoryboardHelper.swift
//  GitTest
//
//  Created by Masuhara on 2015/09/18.
//  Copyright © 2015年 AuraOtsuka. All rights reserved.
//

import UIKit

class StoryboardHelper: NSObject {
    class func adjustMain() -> UIStoryboard {
        var storyboard = UIStoryboard()
        let height = UIScreen.mainScreen().bounds.size.height
        if height == 667 {
            // iPhone6
            storyboard = UIStoryboard(name: "Top-Main", bundle: nil)
        }else if height == 736 {
            // iPhone6 Plus
            storyboard = UIStoryboard(name: "Top-Main", bundle: nil)
        }else if height == 480 {
            // iPhone4s
            storyboard = UIStoryboard(name: "Top-3.5inch", bundle: nil)
        }else if height == 1024 {
            // iPad
            storyboard = UIStoryboard(name: "Top-3.5inch", bundle: nil)
        }else {
            // iPhone5・5s・5c + 何も読み込めなかった場合
            storyboard = UIStoryboard(name: "Top-Main", bundle: nil)
        }
        return storyboard
    }
    
    class func adjustUnivUser() -> UIStoryboard {
        var storyboard = UIStoryboard()
        let height = UIScreen.mainScreen().bounds.size.height
        if height == 667 {
            // iPhone6
            storyboard = UIStoryboard(name: "UnivUser-Main", bundle: nil)
        }else if height == 736 {
            // iPhone6 Plus
            storyboard = UIStoryboard(name: "UnivUser-Main", bundle: nil)
        }else if height == 480 {
            // iPhone4s
            storyboard = UIStoryboard(name: "UnivUser-3.5inch", bundle: nil)
        }else if height == 1024 {
            // iPad
            storyboard = UIStoryboard(name: "UnivUser-3.5inch", bundle: nil)
        }else {
            // iPhone5・5s・5c + 何も読み込めなかった場合
            storyboard = UIStoryboard(name: "UnivUser-Main", bundle: nil)
        }
        return storyboard
    }
}
