//
//  QuestionViewController.swift
//  MatchyTest01
//
//  Created by 井上航 on 2016/09/03.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    let personImageNameArray = ["aguri.jpg",
                                "daifuku1.jpg",
                                "honami1.jpg",
                                "horse01.png",
                                "daifuku1.jpg",
                                "kobaton.jpg",
                                "monkey01.png",
                                "saki1.jpg",
                                "honami1.jpg"]
    
    let postArray = ["question001",
                     "question002question002",
                     "question003question003question003",
                     "question004question004question004question004",
                     "question005question005question005question005question005",
                     "question006question006question006question006\nquestion006\nquestion006",
                     "question007question007question007question007\nquestion007\nquestion007question007",
                     "question008question008question008question008\nquestion008\nquestion008",
                     "question009question009question009question009\nquestion009\nquestion009question009\nquestion009\nquestion009question009\nquestion009\nquestion009question009\nquestion009\nquestion009question009\nquestion009\nquestion009question009\nquestion009\nquestion009question009\nquestion009\nquestion009question009\nquestion009\nquestion009question009\nquestion009\nquestion009question009\nquestion009\nquestion009question009\nquestion009\nquestion009question009\nquestion009\nquestion009question009"]
    
    @IBOutlet weak var questionTableView: UITableView!
    
    var selectedIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        questionTableView.delegate = self
        questionTableView.dataSource = self
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toQuestionDetailVC" {
            let nextVC = segue.destinationViewController as! QuestionDetailViewController
            nextVC.selectedPersonImageName = personImageNameArray[selectedIndex]
            nextVC.selectedDetailText = postArray[selectedIndex]
        }
    }
    
}

extension QuestionViewController: UITableViewDelegate, UITableViewDataSource {
    // セルの個数を指定するデリゲートメソッド（必須）
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    
    // セルに値を設定するデータソースメソッド（必須）
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // セルを取得
        let cell = tableView.dequeueReusableCellWithIdentifier("QuestionPostCell") as! QuestionPostTableViewCell
        
        // セルに値を設定
        cell.setCell(nameText: personImageNameArray[indexPath.row],
                     detailText: postArray[indexPath.row],
                     iconImageNameText: personImageNameArray[indexPath.row])
        
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedIndex = indexPath.row
        performSegueWithIdentifier("toQuestionDetailVC", sender: nil)
    }
}



