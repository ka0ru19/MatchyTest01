//
//  QuestionViewController.swift
//  MatchyTest01
//
//  Created by 井上航 on 2016/09/03.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
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
    
    let postArray = ["question001",
                     "question002question002",
                     "question003question003question003",
                     "question004question004question004question004",
                     "question005question005question005question005question005",
                     "question006question006question006question006\nquestion006\nquestion006",
                     "question007question007question007question007\nquestion007\nquestion007question007",
                     "question008question008question008question008\nquestion008\nquestion008",
                     "question009question009question009question009\nquestion009\nquestion009question009\nquestion009\nquestion009question009\nquestion009\nquestion009question009\nquestion009\nquestion009question009\nquestion009\nquestion009question009\nquestion009\nquestion009question009\nquestion009\nquestion009question009\nquestion009\nquestion009question009\nquestion009\nquestion009question009\nquestion009\nquestion009question009\nquestion009\nquestion009question009\nquestion009\nquestion009question009"]
    
    let answerDeadlineArray = ["2016/9/7 20:11",
                               "2016/9/8 20:13",
                               "2016/9/8 23:41",
                               "2016/9/9 0:01",
                               "2016/9/9 2:51",
                               "2016/9/9 12:19",
                               "2016/9/9 20:11",
                               "2016/9/10 20:14",
                               "2016/9/11 20:21"] // 日本時間
    
    let isAsweredArray = [true,false,true,true,false,true,false,false,true]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionTableView.delegate = self
        questionTableView.dataSource = self
        
        loadFirstQuestionList()
        
    }
    
    override func viewWillAppear(animated: Bool) {
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
            question.questionText = postArray[i]
            question.isQuestionAnswerd = isAsweredArray[i]
            question.answerDeadlineText = answerDeadlineArray[i]
            question.answerReward = String(123 * i)
            questionList.append(question)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toQuestionDetailVC" {
            let nextVC = segue.destinationViewController as! QuestionDetailViewController
            // 任意のquestionをtableviewから削除するのに使う
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

// 任意のquestionをtableviewから削除するのに使う
extension QuestionViewController: RemoveSelectedQuestionDelegate /*onTappedAnswerRefuseOK*/ {
    func removeSelectedQuestion(index: Int) {
        questionList.removeAtIndex(index)
    }
}

extension QuestionViewController: UITableViewDelegate, UITableViewDataSource {
    // セルの個数を指定するデリゲートメソッド（必須）
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionList.count
    }
    
    // セルに値を設定するデータソースメソッド（必須）
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // セルを取得
        let cell = tableView.dequeueReusableCellWithIdentifier("QuestionPostCell") as! QuestionPostTableViewCell
        
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


