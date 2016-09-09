//
//  Respondent.swift
//  MatchyTest01
//
//  Created by 井上航 on 2016/09/08.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit

class RespondentModel {
    
    var name: String!
    var iconName: String!
    var iconNSData: NSData!
    var iconImage: UIImage!
    var isQuestionAnswerd: Bool = false
    var answerText: String = ""
    var answerDateText: String!
    var answerDate: NSDate!
    
    // 配置
    var answerCellHeight: CGFloat!

}
