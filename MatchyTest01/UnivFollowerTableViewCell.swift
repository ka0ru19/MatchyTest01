//
//  UnivFollowerTableViewCell.swift
//  MatchyTest01
//
//  Created by 井上航 on 2016/09/03.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit

class UnivFollowerTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var introductionLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /// 画像・タイトル・説明文を設定するメソッド
    func setCell(imageName imageName: String, nameText: String, introductionText: String) {
        iconImageView.image = UIImage(named: imageName)
        nameLabel.text = nameText
        introductionLabel.text = "私の名前は\(introductionText)です。"
    }

}
