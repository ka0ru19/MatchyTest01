//
//  QuestionModel.swift
//  MatchyTest01
//
//  Created by 井上航 on 2016/09/06.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import Foundation

class QuestionModel {
    
    
    var questionerName: String!
    var questionerIconNSData: NSData!
    var questionerIconName: String!
    var questionText: String!
    var isQuestionAnswerd: Bool = false
    var answerDeadlineText: String! // format: 2016-09-06 17:09
    var answerReward: String!
    var answerText: String!
    
}
