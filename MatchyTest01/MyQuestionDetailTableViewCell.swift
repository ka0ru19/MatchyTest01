//
//  QuestionDetailForHighSchTableViewCell.swift
//  MatchyTest01
//
//  Created by 井上航 on 2016/09/09.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit

class MyQuestionDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var questionTitleLabel: UILabel!
    @IBOutlet weak var questionPostDateLabel: UILabel!
    @IBOutlet weak var questionDetailTextView: UITextView!
    @IBOutlet weak var questionOptionButton: UIButton!
    @IBOutlet weak var answerRewardLabel: UILabel!
    @IBOutlet weak var answerDeadlineLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setQuestionCell(question: QuestionForHighSchModel) {
        
        questionTitleLabel.font = UIFont.boldSystemFontOfSize(CGFloat(16))
        questionPostDateLabel.font = UIFont.systemFontOfSize(CGFloat(11))
        questionPostDateLabel.textColor = UIColor.darkGrayColor()
        questionPostDateLabel.textAlignment = .Right
        
        let fixedWidth = questionDetailTextView.frame.size.width
        let newSize = questionDetailTextView.sizeThatFits(CGSizeMake(fixedWidth, CGFloat.max))
        var newFrame = questionDetailTextView.frame
        newFrame.size = CGSizeMake(max(newSize.width, fixedWidth), newSize.height)
        print(newFrame)
        questionDetailTextView.frame = newFrame
        questionDetailTextView.font = UIFont.systemFontOfSize(CGFloat(14))
        
        
        questionTitleLabel.text = question.questionTitle
        questionPostDateLabel.text = question.questionPostDateText
        questionDetailTextView.text = question.questionText
//        questionOptionButton = 
        answerRewardLabel.text = question.answerReward + "助貨"
        answerDeadlineLabel.text =
            question.answerDeadlineDateText.calcDeadlineIntervalFromNow().setLastTimeText()

        
        
//        let questionTextWithoutNewParagraph =
//            question.questionText.stringByReplacingOccurrencesOfString("\n", withString: " ")
//        nameLabel.text = question.questionerName
//        detailLabel.text = "私の質問は\(questionTextWithoutNewParagraph)です。"
//        iconImageView.image = UIImage(data: question.questionerIconNSData)
//        
//        if question.isQuestionAnswerd {
//            answerRewardLabel.text = String(question.answerReward) + "助貨"
//            answerRewardLabel.backgroundColor = MatchyColor.answerBackgroundColor
//            deadlineLabel.text = "回答完了"
//        } else {
//            // もしまだ期限前なら
//            if question.answerDeadlineText.calcDeadlineIntervalFromNow() > 0 {
//                answerRewardLabel.text = String(question.answerReward) + "助貨"
//                answerRewardLabel.backgroundColor = MatchyColor.questionBackgroundColor
//                deadlineLabel.text = "回答期限: " +
//                    question.answerDeadlineText.calcDeadlineIntervalFromNow().setLastTimeText()
//            }
//                // もう期限を過ぎていたら
//            else {
//                answerRewardLabel.text = String(question.answerReward) + "助貨"
//                answerRewardLabel.backgroundColor = MatchyColor.endBackgroundColor
//                deadlineLabel.text = "回答期限切れ"
//            }
//        }
    }
    
    func setQuestionCellHeight(inout question: QuestionForHighSchModel) {
        question.questionDetailCellHeight = CGFloat(180)
    }
}
