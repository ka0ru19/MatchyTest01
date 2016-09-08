//
//  QuestionDetailViewController.swift
//  MatchyTest01
//
//  Created by 井上航 on 2016/09/03.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit

// 任意のquestionをtableviewから削除するのに使う
protocol RemoveSelectedQuestionDelegate: class {
    func removeSelectedQuestion(index: Int)
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
    
    var selectedQuestion = QuestionForUnivModel()
    var selectedIndex: Int!
    
    let margin: CGFloat = 8.0 // パーツ間の余白
    var scrollHeight: CGFloat!
    
    var removeSelectedQuestionDelegate: RemoveSelectedQuestionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionerNameLabel.font = UIFont.boldSystemFontOfSize(CGFloat(16))
        
        questionerTascaLabel.font = UIFont.systemFontOfSize(CGFloat(13))
        questionerTascaLabel.textAlignment = .Center
        
        answerDeadlineLabel.textColor = UIColor.darkGrayColor()
        answerDeadlineLabel.font = UIFont.systemFontOfSize(CGFloat(11))
        answerDeadlineLabel.textAlignment = .Right
        
        questionTextView.delegate = self
        questionTextView.editable = false // テキスト編集可能性
        questionTextView.scrollEnabled = false
        questionTextView.font = UIFont.systemFontOfSize(CGFloat(16))
        questionTextView.backgroundColor = MatchyColor.questionBackgroundColor
        
        displayUIPartsContents()
        adjsutTextViewHeight()
        adjsutButtonStartY()
        adjsutScrollViewHeight()
    }
    
    func displayUIPartsContents() {
        questionerIconImageView.image = UIImage(data: selectedQuestion.questionerIconNSData)
        questionerNameLabel.text = selectedQuestion.questionerName
        
        // もしまだ期限前なら
        if selectedQuestion.answerDeadlineText.calcDeadlineIntervalFromNow() > 0 {
            questionerTascaLabel.text = String(selectedQuestion.answerReward) + "助貨"
            questionerTascaLabel.backgroundColor = MatchyColor.questionBackgroundColor
            answerDeadlineLabel.text = "回答期限: " +
                selectedQuestion.answerDeadlineText.calcDeadlineIntervalFromNow().setLastTimeText()
        }
            // もう期限を過ぎていたら
        else {
            questionerTascaLabel.text = String(selectedQuestion.answerReward) + "助貨"
            questionerTascaLabel.backgroundColor = MatchyColor.endBackgroundColor
            answerDeadlineLabel.text = "回答期限切れ"
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
        scrollHeight = newFrame.origin.y + newFrame.size.height + margin
        
        view.setNeedsLayout()
    }
    
    func adjsutButtonStartY() {
        
        // もしまだ期限前なら
        if selectedQuestion.answerDeadlineText.calcDeadlineIntervalFromNow() > 0 {
            questionTextView.text = selectedQuestion.questionText
            
            answerRefuseButton.frame.origin.y = scrollHeight
            answerInputButton.frame.origin.y = scrollHeight
            
            scrollHeight = scrollHeight + answerRefuseButton.frame.height + margin
        }
            // もう期限を過ぎていたら
        else {
            // 回答ボタンを消す
            answerRefuseButton.removeFromSuperview()
            answerInputButton.removeFromSuperview()
        }
        
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
            self.removeSelectedQuestionDelegate?.removeSelectedQuestion(self.selectedIndex)
            
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


