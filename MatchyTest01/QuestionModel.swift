//
//  QuestionModel.swift
//  MatchyTest01
//
//  Created by 井上航 on 2016/09/06.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import Foundation
import UIKit

class QuestionModel {
    
    var questionerName: String!
    var questionerIconNSData: NSData!
    var questionerIconName: String!
    var questionerIconImage: UIImage!
    var questionText: String!
    var isQuestionAnswerd: Bool = false
    var answerDeadlineText: String! // format: 2016-09-06 17:09
    var answerDeadlineDate: NSDate!
    var answerReward: String!
    var answerText: String!
    
    func writeQuestionAnswerText(answerText: String) {
        isQuestionAnswerd = true
        self.answerText = answerText
        print(answerText)
        print(self.answerText)
    }
    
}
