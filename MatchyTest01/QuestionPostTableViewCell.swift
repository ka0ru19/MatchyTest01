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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // 複数行表示を許可
        detailLabel.numberOfLines = 2
        detailLabel.lineBreakMode = .ByCharWrapping
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(nameText nameText: String, detailText: String, iconImageNameText: String) {
        nameLabel.text = nameText
        detailLabel.text = "私の質問は\(detailText)です。"
        iconImageView.image = UIImage(named: iconImageNameText)
    }

    
}
