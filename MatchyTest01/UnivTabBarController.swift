//
//  UnivTabBarController.swift
//  MatchyTest01
//
//  Created by 井上航 on 2016/09/05.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit

class UnivTabBarController: UITabBarController {

    var window: UIWindow?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("UnivTabBarController -> viewDidLoad")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
