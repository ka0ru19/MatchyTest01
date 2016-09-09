//
//  QuestionForHighSchModel.swift
//  MatchyTest01
//
//  Created by 井上航 on 2016/09/08.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit

// 自分の質問のモデル
class QuestionForHighSchModel {
    
    var questionerName: String! // 自分
    var questionerIconNSData: NSData! // 自分
    var questionerIconName: String! // 自分
    var questionerIconImage: UIImage! // 自分
    var questionTitle: String!
    var questionText: String!
    var questionPostDateText: String!
    var questionPostDate: NSDate!
    
    var answerDeadlineDateText: String! // format: 2016-09-06 17:09
    var answerDeadlineDate: NSDate!
    var answerReward: String! // 650助貨 -> 650
    
    var respondents = [RespondentModel]() // 質問の相手 1~5
    
    // 配置
    var questionDetailCellHeight: CGFloat!
}
