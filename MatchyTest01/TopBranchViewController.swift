//
//  ViewController.swift
//  MatchyTest01
//
//  Created by 井上航 on 2016/08/25.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit

class TopBranchViewController: UIViewController {

    var window: UIWindow? // StoryboardHelperで使う
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTappedUniv(sender: UIButton) {
        // 画面遷移
        let storyboard: UIStoryboard =  UIStoryboard(name: "UnivUser-Main",bundle:nil)
        var nextVC: UITabBarController //UIViewController!
        nextVC = storyboard.instantiateViewControllerWithIdentifier("UnivStoryBoardTop") as! UITabBarController
        self.presentViewController(nextVC, animated: true, completion: nil)
    }
    
    @IBAction func onTappedHiSch(sender: UIButton) {
        
    }

}

