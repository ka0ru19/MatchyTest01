//
//  myQuestionListTableViewCell.swift
//  MatchyTest01
//
//  Created by 井上航 on 2016/09/08.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit

class MyQuestionListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var questionTitleLabel: UILabel!
    @IBOutlet weak var questionPostDateLabel: UILabel!
    @IBOutlet weak var questionDetailLabel: UILabel!
    @IBOutlet weak var questionOptionButton: UIButton!
    @IBOutlet weak var respondent0IconImageView: UIImageView!
    @IBOutlet weak var respondent1IconImageView: UIImageView!
    @IBOutlet weak var respondent2IconImageView: UIImageView!
    @IBOutlet weak var respondent3IconImageView: UIImageView!
    @IBOutlet weak var respondent4IconImageView: UIImageView!
    @IBOutlet weak var answerRewardLabel: UILabel!
    @IBOutlet weak var answerDeadlineLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCellUIParts()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setCell(question: QuestionForHighSchModel) {
        
        questionTitleLabel.text = question.questionTitle
        questionPostDateLabel.text = question.questionPostDateText
        questionDetailLabel.text = question.questionText.stringByReplacingOccurrencesOfString("\n", withString: " ")
        //        questionOptionButton
        let respondentIconImageViewArray: [UIImageView] = [respondent0IconImageView,
                                                           respondent1IconImageView,
                                                           respondent2IconImageView,
                                                           respondent3IconImageView,
                                                           respondent4IconImageView]
        for i in 0 ..< question.respondents.count {
            respondentIconImageViewArray[i].image = question.respondents[i].iconImage
            respondentIconImageViewArray[i].layer.borderWidth = 4
            if question.respondents[i].isQuestionAnswerd == true {
                respondentIconImageViewArray[i].layer.borderColor = MatchyColor.answerBackgroundColor.CGColor
            } else {
                respondentIconImageViewArray[i].layer.borderColor = MatchyColor.questionBackgroundColor.CGColor
                
            }
        }
        answerRewardLabel.text = question.answerReward + "助貨"
        answerDeadlineLabel.text = question.answerDeadlineDateText.calcDeadlineIntervalFromNow().setLastTimeText()
        
    }
}

extension MyQuestionListTableViewCell {
    func setupCellUIParts() {
        questionTitleLabel.font = UIFont.boldSystemFontOfSize(CGFloat(16))
        
        questionPostDateLabel.textAlignment = .Right
        questionPostDateLabel.textColor = UIColor.darkGrayColor()
        questionPostDateLabel.font = UIFont.systemFontOfSize(CGFloat(11))
        
        questionDetailLabel.numberOfLines = 3
        questionDetailLabel.lineBreakMode = .ByCharWrapping
        questionDetailLabel.font = UIFont.systemFontOfSize(CGFloat(13))
//        questionOptionButton
        
        answerRewardLabel.textAlignment = .Right
        answerRewardLabel.textColor = UIColor.darkGrayColor()
        answerRewardLabel.font = UIFont.systemFontOfSize(CGFloat(10))
        
        answerDeadlineLabel.textAlignment = .Right
        answerDeadlineLabel.textColor = UIColor.darkGrayColor()
        answerDeadlineLabel.font = UIFont.systemFontOfSize(CGFloat(10))
    }
}

