//
//  QuestionViewController.swift
//  MatchyTest01
//
//  Created by 井上航 on 2016/09/03.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit

class QuestionListViewController: UIViewController {
    
    @IBOutlet weak var questionTableView: UITableView!
    
    var questionList = [QuestionForUnivModel]()
    
    var selectedIndex: Int!
    
    let personImageNameArray = ["dog.jpeg",
                                "daifuku1.jpg",
                                "honami1.jpg",
                                "horse01.png",
                                "daifuku1.jpg",
                                "kobaton.jpg",
                                "monkey01.png",
                                "saki1.jpg",
                                "honami1.jpg"]
    
    let postTitleArray = ["title001","title002","title003","title004","title005","title006","title007","title008","title009"]
    
    let postArray = ["question001",
                     "question002question002",
                     "question003question003question003",
                     "question004question004question004question004",
                     "question005question005question005question005question005",
                     "question006question006question006question006\nquestion006\nquestion006",
                     "question007question007question007question007\nquestion007\nquestion007question007",
                     "question008question008question008question008\nquestion008\nquestion008",
                     "question009question009question009question009\nquestion009\nquestion009question009\nquestion009\nquestion009question009\nquestion009\nquestion009question009\nquestion009\nquestion009question009\nquestion009\nquestion009question009\nquestion009\nquestion009question009\nquestion009\nquestion009question009\nquestion009\nquestion009question009\nquestion009\nquestion009question009\nquestion009\nquestion009question009\nquestion009\nquestion009question009\nquestion009\nquestion009question009"]
    
    let sampleQuestionPostDateArray = ["2016/09/08 22:49",
                                       "2016/09/07 1:39",
                                       "2016/09/06 5:40",
                                       "2016/09/05 19:44",
                                       "2016/09/04 14:19",
                                       "2016/09/03 20:09",
                                       "2016/09/03 19:44",
                                       "2016/09/03 14:19",
                                       "2016/09/03 2:09"
    ]
    
    let answerDeadlineArray = ["2016/9/27 20:11",
                               "2016/9/26 20:13",
                               "2016/9/26 23:41",
                               "2016/9/25 20:01",
                               "2016/9/25 12:51",
                               "2016/9/25 12:19",
                               "2016/9/24 20:11",
                               "2016/9/14 20:14",
                               "2016/9/13 20:21"] // 日本時間
    
    let isAsweredArray = [true,false,true,true,false,true,false,false,true]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionTableView.delegate = self
        questionTableView.dataSource = self
        questionTableView.registerNib(UINib(nibName: "QuestionListTableViewCell", bundle: nil), forCellReuseIdentifier: "QuestionListCell")
        questionTableView.estimatedRowHeight = 2000 //CGFloat.max
        questionTableView.rowHeight = UITableViewAutomaticDimension

    }
    
    override func viewWillAppear(animated: Bool) {
        loadFirstQuestionList()
        
        questionTableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadFirstQuestionList() {
        questionList = []
        for i in 0 ..< postArray.count {
            let question = QuestionForUnivModel()
            question.questionerName = personImageNameArray[i]
            question.questionerIconNSData =
                UIImageJPEGRepresentation(UIImage(named: personImageNameArray[i])!, 0.3)
            question.questionerIconName = personImageNameArray[i]
            question.questionTitle = postTitleArray[i]
            question.questionText = postArray[i]
            question.isQuestionAnswerd = isAsweredArray[i]
            question.questionPostDateText = sampleQuestionPostDateArray[i]
            question.answerDeadlineText = answerDeadlineArray[i]
            question.answerReward = String(123 * i)
            questionList.append(question)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toQuestionDetailVC" {
            let nextVC = segue.destinationViewController as! QuestionDetailViewController
            // 2-1.任意のquestionをtableviewから削除するのに使う
            nextVC.removeSelectedQuestionDelegate = self
            nextVC.selectedIndex = self.selectedIndex
            nextVC.selectedQuestion = questionList[self.selectedIndex]
        } else if segue.identifier == "toAnswerConfirmVC" {
            let nextVC = segue.destinationViewController as! AnswerConfirmViewController
            nextVC.selectedIndex = self.selectedIndex
            nextVC.selectedQuestion = questionList[self.selectedIndex]
        }
    }
    
}

// 2-2.任意のquestionをtableviewから削除するのに使う
extension QuestionListViewController: RemoveSelectedQuestionDelegate /*onTappedAnswerRefuseOK*/ {
    func removeSelectedQuestion(index: Int) {
        questionList.removeAtIndex(index)
    }
}

extension QuestionListViewController: UITableViewDelegate, UITableViewDataSource {
    // セルの個数を指定するデリゲートメソッド（必須）
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionList.count
    }
    
    // セルに値を設定するデータソースメソッド（必須）
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // セルを取得
        let cell = tableView.dequeueReusableCellWithIdentifier("QuestionListCell") as! QuestionListTableViewCell
        
        print(indexPath.row)
        print(questionList[indexPath.row].questionerName)
        
        // セルに値を設定
        cell.setCell(questionList[indexPath.row])
        
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedIndex = indexPath.row
        if questionList[selectedIndex].isQuestionAnswerd == false {
            performSegueWithIdentifier("toQuestionDetailVC", sender: nil)
        } else {
            performSegueWithIdentifier("toAnswerConfirmVC", sender: nil)
        }
    }
}


