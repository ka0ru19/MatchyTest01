//
//  QuestionPostTableViewCell.swift
//  MatchyTest01
//
//  Created by 井上航 on 2016/09/03.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit

class QuestionPostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var answerRewardLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var deadlineLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
        answerRewardLabel.font = UIFont.systemFontOfSize(CGFloat(12))
        answerRewardLabel.textAlignment = .Center
        answerRewardLabel.layer.masksToBounds = true
        answerRewardLabel.layer.cornerRadius = answerRewardLabel.frame.height / 2
        
        nameLabel.font = UIFont.boldSystemFontOfSize(CGFloat(16))
        
        deadlineLabel.textColor = UIColor.darkGrayColor()
        deadlineLabel.font = UIFont.systemFontOfSize(CGFloat(11))
        
        detailLabel.numberOfLines = 2
        detailLabel.lineBreakMode = .ByCharWrapping
        detailLabel.font = UIFont.systemFontOfSize(CGFloat(13))
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setCell(question: QuestionForUnivModel) {
        let questionTextWithoutNewParagraph =
            question.questionText.stringByReplacingOccurrencesOfString("\n", withString: " ")
        nameLabel.text = question.questionerName
        detailLabel.text = "私の質問は\(questionTextWithoutNewParagraph)です。"
        iconImageView.image = UIImage(data: question.questionerIconNSData)
        
        if question.isQuestionAnswerd {
            answerRewardLabel.text = String(question.answerReward) + "助貨"
            answerRewardLabel.backgroundColor = MatchyColor.answerBackgroundColor
            deadlineLabel.text = "回答完了"
        } else {
            // もしまだ期限前なら
            if question.answerDeadlineText.calcDeadlineIntervalFromNow() > 0 {
                answerRewardLabel.text = String(question.answerReward) + "助貨"
                answerRewardLabel.backgroundColor = MatchyColor.questionBackgroundColor
                deadlineLabel.text = "回答期限: " +
                    question.answerDeadlineText.calcDeadlineIntervalFromNow().setLastTimeText()
            }
                // もう期限を過ぎていたら
            else {
                answerRewardLabel.text = String(question.answerReward) + "助貨"
                answerRewardLabel.backgroundColor = MatchyColor.endBackgroundColor
                deadlineLabel.text = "回答期限切れ"
            }
        }
    }
}
