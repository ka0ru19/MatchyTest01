//
//  AnswerForHighSchTableViewCell.swift
//  MatchyTest01
//
//  Created by 井上航 on 2016/09/09.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit

class AnswerForHighSchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var answerTextView: UITextView!
    @IBOutlet weak var optionButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setAnswerCell(respondent: RespondentModel) {
        
        dateLabel.font = UIFont.systemFontOfSize(CGFloat(11))
        dateLabel.textColor = UIColor.darkGrayColor()
        dateLabel.textAlignment = .Right
        
        iconImageView.image = UIImage(data: respondent.iconNSData)
        nameLabel.text = respondent.name
        
        if respondent.answerText == "" {
            dateLabel.text = "未回答"
            answerTextView.hidden = true
            
        } else {
            let fixedWidth = answerTextView.frame.size.width
            let newSize = answerTextView.sizeThatFits(CGSizeMake(fixedWidth, CGFloat.max))
            var newFrame = answerTextView.frame
            newFrame.size = CGSizeMake(max(newSize.width, fixedWidth), newSize.height)
            print(newFrame)
            answerTextView.frame = newFrame
            answerTextView.font = UIFont.systemFontOfSize(CGFloat(14))
            answerTextView.backgroundColor = UIColor.cyanColor()
            answerTextView.hidden = false
            answerTextView.text = respondent.answerText
            dateLabel.text = respondent.answerDateText
        }
        
        
    }
}
