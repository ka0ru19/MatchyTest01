//
//  SelfInfoViewController.swift
//  MatchyTest01
//
//  Created by 井上航 on 2016/09/03.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit

class UnivMyPageViewController: UIViewController {
    
    @IBOutlet weak var selfNameLabel: UILabel!
    @IBOutlet weak var selfIconImageView: UIImageView!
    @IBOutlet weak var selfFollowerLabel: UILabel!
    @IBOutlet weak var selfIntroductionTextView: UITextView!
    
    @IBOutlet weak var followerTableView: UITableView!
    
    let selfImageName = "inocci.png"
    let personImageNameArray = ["aguri.jpg",
                                "daifuku1.jpg",
                                "honami1.jpg",
                                "horse01.png",
                                "kobaton.jpg",
                                "monkey01.png",
                                "saki1.jpg"]

    override func viewDidLoad() {
        super.viewDidLoad()

        followerTableView.delegate = self
        followerTableView.dataSource = self
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

extension UnivMyPageViewController: UITableViewDelegate, UITableViewDataSource {
    
    // セルの個数を指定するデリゲートメソッド（必須）
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personImageNameArray.count
    }
    
    // セルに値を設定するデータソースメソッド（必須）
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // セルを取得
        let cell = tableView.dequeueReusableCellWithIdentifier("FollowerCell") as! UnivFollowerTableViewCell
        
        // セルに値を設定
        cell.setCell(imageName: personImageNameArray[indexPath.row],
                     nameText: personImageNameArray[indexPath.row],
                     introductionText: personImageNameArray[indexPath.row])
        
        return cell
    }
}
