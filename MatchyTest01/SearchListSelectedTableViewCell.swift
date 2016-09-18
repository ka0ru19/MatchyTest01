//
//  SearchListSelectedTableViewCell.swift
//  MatchyTest01
//
//  Created by 井上航 on 2016/09/11.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit

// 1-1.任意の選択肢をtableviewから削除するのに使う
protocol RemoveSelectedSelectionDelegate: class {
    func removeSelectedSelection(section section: Int, row: Int)
}

class SearchListSelectedTableViewCell: UITableViewCell {

    @IBOutlet weak var selectedLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    var selfIndexSection: Int!
    var selfIndexRow: Int!
    
    // 1-2. delegateの設定
    var removeSelectedSelectionDelegate: RemoveSelectedSelectionDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        selectedLabel.font = UIFont.systemFontOfSize(CGFloat(15))
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setSelectCell(selectedText: String, section: Int, row: Int) {
        selfIndexSection = section
        selfIndexRow = row
        selectedLabel.textColor = UIColor.blackColor()
        selectedLabel.text = selectedText
        deleteButton.hidden = false
    }
    
    func initSelectCell() {
        selectedLabel.textColor = UIColor.lightGrayColor()
        selectedLabel.text = "未選択"
        deleteButton.hidden = true
    }
    
    @IBAction func onDeleteButtonTapped(sender: UIButton) {
        print("onDeleteButtonTapped")
        // 1-3. cellからこの質問を削除
        self.removeSelectedSelectionDelegate?.removeSelectedSelection(section: selfIndexSection,
                                                                      row: selfIndexRow)
    }
    
}
