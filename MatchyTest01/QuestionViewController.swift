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
    
    var questionList = [QuestionModel]()
    
    var selectedIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
            let question = QuestionModel()
            question.questionerName = personImageNameArray[i]
            question.questionerIconNSData =
                UIImageJPEGRepresentation(UIImage(named: personImageNameArray[i])!, 0.3)
            question.questionerIconName = personImageNameArray[i]
            question.questionText = postArray[i]
            question.isQuestionAnswerd = false
            question.answerDeadlineText = "2016-09-08 17:39"
            question.answerReward = String(123 * i)
            questionList.append(question)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toQuestionDetailVC" {
            let nextVC = segue.destinationViewController as! QuestionDetailViewController
            // 任意のquestionをtableviewから削除するのに使う
            nextVC.removeIndexDelegate = self
            nextVC.selectedIndex = self.selectedIndex
            nextVC.selectedQuestion = questionList[self.selectedIndex]
        }
    }
    
}

// 任意のquestionをtableviewから削除するのに使う
extension QuestionViewController: onTappedAnswerRefuseOK {
    func removeQuestion(index: Int) {
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
        performSegueWithIdentifier("toQuestionDetailVC", sender: nil)
    }
}



