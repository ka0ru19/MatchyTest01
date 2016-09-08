//
//  AnswerConfirmViewController.swift
//  MatchyTest01
//
//  Created by 井上航 on 2016/09/05.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit

class AnswerConfirmViewController: UIViewController {
    
    @IBOutlet weak var answerConfirmScrollView: UIScrollView!
    
    @IBOutlet weak var questionerIconImageView: UIImageView!
    @IBOutlet weak var questionerNameLabel: UILabel!
    @IBOutlet weak var questionerTascaLabel: UILabel!
    @IBOutlet weak var answerDeadlineLabel: UILabel!
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var separateYourAnswerLabel: UILabel!
    @IBOutlet weak var answerTextView: UITextView!
    
    @IBOutlet weak var answerReEditButton: UIButton!
    @IBOutlet weak var answerFinishButton: UIButton!
    
    var selectedQuestion = QuestionModel()
    var selectedIndex: Int!
    
    let margin: CGFloat = 8.0 // パーツ間の余白
    var scrollHeight: CGFloat!
    let tabBarHieght = UITabBarController().tabBar.frame.size.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayUIPartsContents()
        setUpTextView()
        setUpQuestionTextViewHeight()
        setUpSeparateYourAnswerLabelPosition()
        setUpanswerTextViewHeight()
        setUpButtonStartY()
        answerConfirmScrollView.contentSize = CGSizeMake(self.view.frame.size.width, scrollHeight)
    }
    
    func displayUIPartsContents() {
        questionerIconImageView.image = UIImage(data: selectedQuestion.questionerIconNSData)
        questionerNameLabel.text = selectedQuestion.questionerName
        separateYourAnswerLabel.text = "あなたの回答"
        
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
        
        answerTextView.text = selectedQuestion.answerText
    }
    
    func setUpTextView() {
        questionTextView.editable = false
        questionTextView.scrollEnabled = false
        questionTextView.font = UIFont.systemFontOfSize(CGFloat(14))
        questionTextView.backgroundColor = MatchyColor.questionBackgroundColor
        
        separateYourAnswerLabel.font = UIFont.systemFontOfSize(CGFloat(10))
        separateYourAnswerLabel.textColor = UIColor.darkGrayColor()
        
        answerTextView.editable = false
        answerTextView.scrollEnabled = false
        answerTextView.font = UIFont.systemFontOfSize(CGFloat(14))
        answerTextView.backgroundColor = MatchyColor.answerBackgroundColor
    }
    
    func setUpQuestionTextViewHeight() { // 最初に一回だけ呼ばれる
        let fixedWidth = questionTextView.frame.size.width
        let newSize = questionTextView.sizeThatFits(CGSizeMake(fixedWidth, CGFloat.max))
        var newFrame = questionTextView.frame
        newFrame.size = CGSizeMake(max(newSize.width, fixedWidth), newSize.height)
        print(newFrame)
        questionTextView.frame = newFrame
        view.setNeedsLayout()
        
        // 下のUIPartsに高さを引き継ぐ
        separateYourAnswerLabel.frame.origin.y = newFrame.origin.y + newFrame.size.height + margin
    }
    
    func setUpSeparateYourAnswerLabelPosition() {
        view.setNeedsLayout()
        // 下のUIPartsに高さを引き継ぐ
        answerTextView.frame.origin.y =
            separateYourAnswerLabel.frame.origin.y + separateYourAnswerLabel.frame.size.height + margin
    }
    
    func setUpanswerTextViewHeight() {
        let fixedWidth = answerTextView.frame.size.width
        let newSize = answerTextView.sizeThatFits(CGSizeMake(fixedWidth, CGFloat.max))
        var newFrame = answerTextView.frame
        newFrame.size = CGSizeMake(max(newSize.width, fixedWidth), newSize.height)
        print(newFrame)
        answerTextView.frame = newFrame
        view.setNeedsLayout()
        
        // 下のUIPartsとscrollHeightに高さを引き継ぐ
        answerReEditButton.frame.origin.y = newFrame.origin.y + newFrame.size.height + margin
        answerFinishButton.frame.origin.y = newFrame.origin.y + newFrame.size.height + margin
        scrollHeight = newFrame.origin.y + newFrame.height + margin
    }
    
    func setUpButtonStartY() {
        if selectedQuestion.isQuestionAnswerd == false {
            scrollHeight = answerReEditButton.frame.origin.y + answerReEditButton.frame.height + margin
        } else {
            answerReEditButton.removeFromSuperview()
            answerFinishButton.removeFromSuperview()
        }
        view.setNeedsLayout()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTappedAnswerReEdit(sender: UIButton) {
        // 一つ前のViewControllerに戻る
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func onTappedAnswerFinish(sender: UIButton) {
        // 入力完了のアラートを表示
        // アラートを表示
        if selectedQuestion.answerDeadlineText.calcDeadlineIntervalFromNow() > 0 {
            let alert: UIAlertController = UIAlertController(title: "完了", message: "回答が完了しました", preferredStyle:  UIAlertControllerStyle.Alert)
            let okAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {(
                action: UIAlertAction!) -> Void in
                self.finishAnswer()
                // 質問一覧のtableViewまで戻る
                self.navigationController?.popToViewController(self.navigationController!.viewControllers[0], animated: true)
                
            })
            alert.addAction(okAction)
            presentViewController(alert, animated: true, completion: nil)
        } else {
            print("回答期限切れ")
            // アラートを表示
            let alert: UIAlertController = UIAlertController(title: "回答期限切れ", message: "手遅れです。。", preferredStyle:  UIAlertControllerStyle.Alert)
            let okAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {(
                action: UIAlertAction!) -> Void in
                // 質問一覧のtableViewまで戻る
                self.navigationController?.popToViewController(self.navigationController!.viewControllers[0], animated: true)
            })
            alert.addAction(okAction)
            presentViewController(alert, animated: true, completion: nil)
            
        }
    }
    
    func finishAnswer() {
        selectedQuestion.writeQuestionAnswerText(self.answerTextView.text)
    }
}


