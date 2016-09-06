//
//  QuestionPostTableViewCell.swift
//  MatchyTest01
//
//  Created by 井上航 on 2016/09/03.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit

class QuestionPostTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var answerStatusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // 複数行表示を許可
        detailLabel.numberOfLines = 2
        detailLabel.lineBreakMode = .ByCharWrapping
        detailLabel.font = UIFont.systemFontOfSize(CGFloat(10))
        
        answerStatusLabel.font = UIFont.systemFontOfSize(CGFloat(14))
        answerStatusLabel.textAlignment = .Center
        answerStatusLabel.backgroundColor = MatchyColor().questionBackgroundColor
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(question: QuestionModel) {
        let questionTextWithoutNewParagraph =
            question.questionText.stringByReplacingOccurrencesOfString("\n", withString: " ")
        nameLabel.text = question.questionerName
        detailLabel.text = "私の質問は\(questionTextWithoutNewParagraph)です。"
        iconImageView.image = UIImage(data: question.questionerIconNSData)
        
        if question.isQuestionAnswerd {
            answerStatusLabel.text = "回答済: " + String(question.answerReward) + "助貨"
            answerStatusLabel.backgroundColor = MatchyColor().answerBackgroundColor
        } else {
            // もしまだ期限前なら
            answerStatusLabel.text = "未回答: " + String(question.answerReward) + "助貨"
            answerStatusLabel.backgroundColor = MatchyColor().questionBackgroundColor
            // もう期限を過ぎていたら
            // answerStatusLabel.text = "回答受付終了"
            // answerStatusLabel.backgroundColor = MatchyColor().endBackgroundColor
        }
    }
    
}
