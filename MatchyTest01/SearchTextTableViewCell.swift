//
//  SearchBarTableViewCell.swift
//  MatchyTest01
//
//  Created by 井上航 on 2016/09/11.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit

class SearchTextTableViewCell: UITableViewCell {
    
    @IBOutlet weak var searchTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        searchTextField.delegate = self
        searchTextField.text = ""
        searchTextField.font = UIFont.systemFontOfSize(CGFloat(15))
        searchTextField.borderStyle = .None
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func initWordCell() {
        searchTextField.placeholder = "未入力"
        searchTextField.attributedPlaceholder =
            NSAttributedString(string:"未入力", attributes:[
                NSForegroundColorAttributeName: UIColor.lightGrayColor(),
                NSFontAttributeName :UIFont.systemFontOfSize(CGFloat(15))
                ])
        
        self.selectionStyle = .None
//        self.userInteractionEnabled = false
    }
    
    func setWordCell(word: String) {
        searchTextField.text = word
    }
    
}

extension SearchTextTableViewCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        return true
    }
    
    func textViewDidChange(textView: UITextView) {
    }
}
