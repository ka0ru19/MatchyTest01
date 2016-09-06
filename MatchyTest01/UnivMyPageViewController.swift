//
//  SelfInfoViewController.swift
//  MatchyTest01
//
//  Created by 井上航 on 2016/09/03.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit

class UnivMyPageViewController: UIViewController {
    
    @IBOutlet weak var myNameLabel: UILabel!
    @IBOutlet weak var myIconImageView: UIImageView!
    @IBOutlet weak var myFollowerLabel: UILabel!
    @IBOutlet weak var myIntroductionTextView: UITextView!
    
    @IBOutlet weak var followerTableView: UITableView!
    
    let myImageNameSample = "inocci.png"
    let personImageNameSampleArray = ["aguri.jpg",
                                "daifuku1.jpg",
                                "honami1.jpg",
                                "horse01.png",
                                "kobaton.jpg",
                                "monkey01.png",
                                "saki1.jpg"]
    
    var myImageName = ""
    var followerImageNameArray = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        followerTableView.delegate = self
        followerTableView.dataSource = self
    }
    
    override func viewWillAppear(animated: Bool) {
        // 自分の情報を読み込み、配置
        setUpMyInfomation()
        
        // 自分のfollowerを読み込み、配置(tableViewのreload)
        setUpMyFollower()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpMyInfomation() {
        myImageName = myImageNameSample
        myNameLabel.text = myImageName
        myIconImageView.image = UIImage(named: myImageName)
        myIntroductionTextView.text = "私(Univ)の名前は\(myImageName)です"
    }
    
    func setUpMyFollower() {
        followerImageNameArray = []
        for imageName in personImageNameSampleArray {
            followerImageNameArray.append(imageName)
        }
        followerTableView.reloadData()
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
        return followerImageNameArray.count
    }
    
    // セルに値を設定するデータソースメソッド（必須）
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // セルを取得
        let cell = tableView.dequeueReusableCellWithIdentifier("FollowerCell") as! UnivFollowerTableViewCell
        
        // セルに値を設定
        cell.setCell(imageName: followerImageNameArray[indexPath.row],
                     nameText: followerImageNameArray[indexPath.row],
                     introductionText: followerImageNameArray[indexPath.row])
        
        return cell
    }
}
