//
//  MyQuestionListViewController.swift
//  MatchyTest01
//
//  Created by 井上航 on 2016/09/08.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit

class MyQuestionListViewController: UIViewController {
    
    @IBOutlet weak var myQuestionListTableView: UITableView!
    
    var sampleQuestionList = [QuestionForHighSchModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myQuestionListTableView.delegate = self
        myQuestionListTableView.dataSource = self
    }
    
    override func viewWillAppear(animated: Bool) {
        
        setupSampleQuestionList()
        myQuestionListTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension MyQuestionListViewController {
    func setupSampleQuestionList() {
        
        sampleQuestionList = []
        
        let sampleMyName = "inocci.png"
        
        let sampleQuestionTitleArray = ["質問title1","質問title2","質問title3","質問title4","質問title5","質問title6"]
        let sampleQuestionTextArray = ["question1",
                                       "question2question2",
                                       "question3question3question3question3question3question3",
                                       "question4question4\nquestion4question4question4",
                                       "question5\n\n\n\nquestion5question5\n",
                                       "question6question6question6question6question6question6question6question6question6question6question6question6question6question6question6question6question6question6question6question6question6question6question6question6\n\n\n\n\n\nquestion6question6question6\nquestion6\nquestion6"]
        
        let sampleQuestionPostDateArray = ["2016/09/08 22:49",
                                           "2016/09/07 1:39",
                                           "2016/09/06 5:40",
                                           "2016/09/05 19:44",
                                           "2016/09/04 14:19",
                                           "2016/09/03 20:09"
        ]
        
        let sampleQuestionDeadlineArray = ["2016/09/17 10:33",
                                           "2016/09/16 10:34",
                                           "2016/09/15 10:35",
                                           "2016/09/14 10:36",
                                           "2016/09/13 10:37",
                                           "2016/09/12 10:38"
        ]
        
        let sampleRewardArray = ["150","250","50","450","530","660"]
        
        let respondentNameArray = [["aguri.jpg","daifuku1.jpg","honami1.jpg"],
                                   ["saki1.jpg","maeP.jpg"],
                                   ["shinoki.jpg","hem.jpg","kasumin.jpg","kiyo.jpg"],
                                   ["shota.jpg","kasumin.jpg","kiyo.jpg"],
                                   ["maeP.jpg","shinoki.jpg","daifuku1.jpg"],
                                   ["honami1.jpg","saki1.jpg","shinoki.jpg","kiyo.jpg","maeP.jpg"]
        ]
        
        let sampleIsQuestionAnswerdArray = [[false,true,false],
                                            [true,false],
                                            [false,false,false,true],
                                            [true,false,true],
                                            [false,true,true],
                                            [false,false,true,false,false]]
        
        var sampleQuestionRespondent = [[RespondentModel]]()
        for j in 0 ..< respondentNameArray.count {
            var respondentArray = [RespondentModel]()
            for i in 0 ..< respondentNameArray[j].count {
                let respondent = RespondentModel()
                respondent.name = respondentNameArray[j][i]
                respondent.iconName = respondentNameArray[j][i]
                respondent.iconImage = UIImage(named: respondentNameArray[j][i])
                respondent.iconNSData = UIImageJPEGRepresentation(UIImage(named: respondentNameArray[j][i])!, 0.3)
                respondent.isQuestionAnswerd = sampleIsQuestionAnswerdArray[j][i]
                respondent.answerText = ""
                respondentArray.append(respondent)
            }
            sampleQuestionRespondent.append(respondentArray)
        }
        
        for i in 0 ..< sampleQuestionTitleArray.count {
            let question = QuestionForHighSchModel()
            
            question.questionerName = sampleMyName // 自分
            question.questionerIconNSData = UIImageJPEGRepresentation(UIImage(named: sampleMyName)!, 0.3) // 自分
            question.questionerIconName = sampleMyName  // 自分
            question.questionerIconImage = UIImage(named: sampleMyName) // 自分
            question.questionTitle = sampleQuestionTitleArray[i]
            question.questionText = sampleQuestionTextArray[i]
            question.questionPostDateText = sampleQuestionPostDateArray[i]
            question.questionPostDate = sampleQuestionPostDateArray[i].changeDateStringToNSDate()
            question.answerDeadlineDateText = sampleQuestionDeadlineArray[i] // format: 2016-09-06 17:09
            question.answerDeadlineDate = sampleQuestionDeadlineArray[i].changeDateStringToNSDate()
            question.answerReward = sampleRewardArray[i] // 650助貨 -> 650
            question.respondents = sampleQuestionRespondent[i] // 質問の相手 1~5
            
            sampleQuestionList.append(question)
        }
        
        print(sampleQuestionList)
    }
}

extension MyQuestionListViewController: UITableViewDelegate, UITableViewDataSource {
    // セルの個数を指定するデリゲートメソッド（必須）
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleQuestionList.count
    }
    
    // セルに値を設定するデータソースメソッド（必須）
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // セルを取得
        let cell = tableView.dequeueReusableCellWithIdentifier("QuestionPostCell") as! MyQuestionListTableViewCell
        
        print(indexPath.row)
        print(sampleQuestionList[indexPath.row].questionerName)
        
        // セルに値を設定
        cell.setCell(sampleQuestionList[indexPath.row])
        
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        performSegueWithIdentifier("toQuestionDetailVC", sender: nil)
    }
    
    
}

