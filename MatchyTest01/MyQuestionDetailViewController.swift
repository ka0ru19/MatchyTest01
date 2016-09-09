//
//  MyQuestionDetailViewController.swift
//  MatchyTest01
//
//  Created by 井上航 on 2016/09/09.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit

class MyQuestionDetailViewController: UIViewController {
    
    @IBOutlet weak var questionDetailTableView: UITableView!
    
    var selectedQuestion = QuestionForHighSchModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionDetailTableView.delegate = self
        questionDetailTableView.dataSource = self
        questionDetailTableView.registerNib(UINib(nibName: "QuestionDetailForHighSchTableViewCell", bundle: nil), forCellReuseIdentifier: "QuestionDetailCell")
        questionDetailTableView.registerNib(UINib(nibName: "AnswerForHighSchTableViewCell", bundle: nil), forCellReuseIdentifier: "AnswerCell")
        
        questionDetailTableView.estimatedRowHeight = 300 //CGFloat.max
        questionDetailTableView.rowHeight = UITableViewAutomaticDimension
        
    }
    
    override func viewWillAppear(animated: Bool) {
        questionDetailTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension MyQuestionDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + selectedQuestion.respondents.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("QuestionDetailCell", forIndexPath: indexPath) as! QuestionDetailForHighSchTableViewCell
            cell.setQuestionCell(selectedQuestion)
//            cell.setQuestionCellHeight(&selectedQuestion)
//            print("このcellHeightは\(selectedQuestion.questionDetailCellHeight)")
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("AnswerCell", forIndexPath: indexPath) as! AnswerForHighSchTableViewCell
            cell.setAnswerCell(selectedQuestion.respondents[indexPath.row - 1])
            return cell
            // このあとheightForRowAtIndexPathが呼ばれる
        }
        
    }
    
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        if indexPath.row == 0 {
//            return 180.0 // selectedQuestion.questionDetailCellHeight
//        } else {
//            return CGFloat(120)
//        }
//    }
}