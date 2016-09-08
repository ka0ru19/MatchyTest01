//
//  QuestionModel.swift
//  MatchyTest01
//
//  Created by 井上航 on 2016/09/06.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import Foundation
import UIKit

class QuestionForUnivModel {
    
    var questionerName: String!
    var questionerIconNSData: NSData!
    var questionerIconName: String!
    var questionerIconImage: UIImage!
    var questionText: String!
    
    var isQuestionAnswerd: Bool = false // Respondent次第
    
    var answerDeadlineText: String! // format: 2016-09-06 17:09
    var answerDeadlineDate: NSDate!
    var answerReward: String!
    var answerText: String! // Respondent次第

    // ここはのちにAPIで処理する
    func writeQuestionAnswerText(answerText: String) {
        isQuestionAnswerd = true
        self.answerText = answerText
        print(answerText)
        print(self.answerText)
    }
    
}