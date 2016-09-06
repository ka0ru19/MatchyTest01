//
//  QuestionDetailViewController.swift
//  MatchyTest01
//
//  Created by 井上航 on 2016/09/03.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit

// 任意のquestionをtableviewから削除するのに使う
protocol onTappedAnswerRefuseOK: class {
    func removeQuestion(index: Int)
}

class QuestionDetailViewController: UIViewController {
    
    @IBOutlet weak var questionScrollView: UIScrollView!
    
    @IBOutlet weak var questionerIconImageView: UIImageView!
    @IBOutlet weak var questionerNameLabel: UILabel!
    @IBOutlet weak var questionerTascaLabel: UILabel!
    @IBOutlet weak var answerDeadlineLabel: UILabel!
    @IBOutlet weak var questionTextView: UITextView!
    
    @IBOutlet weak var answerRefuseButton: UIButton!
    @IBOutlet weak var answerInputButton: UIButton!
    
    var selectedQuestion = QuestionModel()
    var selectedIndex: Int!
    
    var selectedPersonImageName: String!
    var selectedDetailText: String!
    
    let matchyColor = MatchyColor()
    
    let margin: CGFloat = 8.0 // パーツ間の余白
    var scrollHeight: CGFloat!
    var buttonStartY: CGFloat!
    
    var removeIndexDelegate: onTappedAnswerRefuseOK?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionTextView.delegate = self
        questionTextView.editable = false // テキスト編集可能性
        questionTextView.scrollEnabled = false
        questionTextView.font = UIFont.systemFontOfSize(CGFloat(16))
        questionTextView.backgroundColor = matchyColor.questionBackgroundColor
        
        displayUIPartsContents()
        adjsutTextViewHeight()
        adjsutButtonStartY()
        adjsutScrollViewHeight()
    }
    
    func displayUIPartsContents() {
        questionerIconImageView.image = UIImage(data: selectedQuestion.questionerIconNSData)
        questionerNameLabel.text = selectedQuestion.questionerName
        
        if selectedQuestion.isQuestionAnswerd {
            questionerTascaLabel.text = "回答済: " + String(selectedQuestion.answerReward) + "助貨"
            questionerTascaLabel.backgroundColor = MatchyColor().answerBackgroundColor
            answerDeadlineLabel.text = "回答済の質問です"
        } else {
            // もしまだ期限前なら
            questionerTascaLabel.text = "未回答: " + String(selectedQuestion.answerReward) + "助貨"
            questionerTascaLabel.backgroundColor = MatchyColor().questionBackgroundColor
            answerDeadlineLabel.text = "回答期限: 残り14時間"
            // もう期限を過ぎていたら
            // questionerTascaLabel.text  = "未回答: " + String(selectedQuestion.answerReward) + "助貨"
            // questionerTascaLabel.backgroundColor = MatchyColor().endBackgroundColor
            // answerDeadlineLabel.text = "回答期限切れです"
        }
        questionTextView.text = selectedQuestion.questionText
    }
    
    func adjsutTextViewHeight() {
        let fixedWidth = questionTextView.frame.size.width
        let newSize = questionTextView.sizeThatFits(CGSizeMake(fixedWidth, CGFloat.max))
        var newFrame = questionTextView.frame
        newFrame.size = CGSizeMake(max(newSize.width, fixedWidth), newSize.height)
        questionTextView.frame = newFrame
        
        // 下のUIPartsに高さを引き継ぐ
        buttonStartY = newFrame.origin.y + newFrame.size.height + margin
        
        view.setNeedsLayout()
    }
    
    func adjsutButtonStartY() {
        answerRefuseButton.frame.origin.y = buttonStartY
        answerInputButton.frame.origin.y = buttonStartY
        
        scrollHeight = buttonStartY + answerRefuseButton.frame.height + margin
        
        view.setNeedsLayout()
    }
    
    func adjsutScrollViewHeight() {
        questionScrollView.contentSize = CGSizeMake(self.view.frame.size.width, scrollHeight)
    }
    
    @IBAction func onTappedAnswerInput(sender: UIButton) {
        performSegueWithIdentifier("toAnswerInputVC", sender: nil)
    }
    
    @IBAction func onTappedAnswerRefuse(sender: UIButton) {
        // アラートを表示
        let alert: UIAlertController = UIAlertController(title: "この質問の回答を拒否します", message: "この操作は取消できません", preferredStyle:  UIAlertControllerStyle.Alert)
        let okAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {(
            action: UIAlertAction!) -> Void in
            // cellからこの質問を削除
            self.removeIndexDelegate?.removeQuestion(self.selectedIndex)
            
            // tableViewに戻る
            self.navigationController?.popToViewController(self.navigationController!.viewControllers[0], animated: true)
        })
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertActionStyle.Cancel, handler:{(
            action: UIAlertAction!) -> Void in
        })
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toAnswerInputVC" {
            let nextVC = segue.destinationViewController as! AnswerInputViewController
            nextVC.selectedIndex = self.selectedIndex
            nextVC.selectedQuestion = self.selectedQuestion
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension QuestionDetailViewController: UITextViewDelegate {
    func textViewDidChange(textView: UITextView) {
        adjsutTextViewHeight()
        adjsutButtonStartY()
        adjsutScrollViewHeight()
    }
    
}


