//
//  AnswerInputViewController.swift
//  MatchyTest01
//
//  Created by 井上航 on 2016/09/03.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit

class AnswerInputViewController: UIViewController {
    
    @IBOutlet weak var answerInputScrollView: UIScrollView!
    
    @IBOutlet weak var questionerIconImageView: UIImageView!
    @IBOutlet weak var questionerNameLabel: UILabel!
    @IBOutlet weak var questionerTascaLabel: UILabel!
    @IBOutlet weak var answerDeadlineLabel: UILabel!
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var answerInputTextView: UITextView!
    
    var selectedQuestion = QuestionModel()
    var selectedIndex: Int!
    
    let matchyColor = MatchyColor()
    
    let margin: CGFloat = 8.0 // パーツ間の余白
    var scrollHeight: CGFloat!
    var keyboardHeight: CGFloat = 0
    
    let tabBarHieght = UITabBarController().tabBar.frame.size.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayUIPartsContents()
        setUpTextView()
        
        let doneNavigationButton = UIBarButtonItem(title: "完了", style: .Done, target: self, action: "inputDone")
        navigationItem.rightBarButtonItem = doneNavigationButton
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        
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

        answerInputTextView.text = "ここに回答を入力"
    }
    
    func setUpTextView() {
        questionTextView.delegate = self
        questionTextView.editable = false
        questionTextView.scrollEnabled = false
        questionTextView.tag = 1
        questionTextView.font = UIFont.systemFontOfSize(CGFloat(12))
        questionTextView.backgroundColor = matchyColor.questionBackgroundColor
        
        answerInputTextView.delegate = self
        answerInputTextView.editable = true
        answerInputTextView.scrollEnabled = false
        answerInputTextView.tag = 2
        answerInputTextView.layer.masksToBounds = true
        answerInputTextView.layer.cornerRadius = 8.0
        answerInputTextView.layer.borderWidth = 1
        answerInputTextView.layer.borderColor = UIColor.blackColor().CGColor
        
        setUpQuestionTextViewHeight()
        adjsutAnswerInputTextViewHeight()
        
        answerInputTextView.becomeFirstResponder()
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
        answerInputTextView.frame.origin.y = newFrame.origin.y + newFrame.size.height + margin
    }
    
    func adjsutAnswerInputTextViewHeight() {
        let fixedWidth = answerInputTextView.frame.size.width
        let newSize = answerInputTextView.sizeThatFits(CGSizeMake(fixedWidth, CGFloat.max))
        var newFrame = answerInputTextView.frame
        newFrame.size = CGSizeMake(max(newSize.width, fixedWidth), newSize.height)
        print(newFrame)
        answerInputTextView.frame = newFrame
        
        scrollHeight = answerInputTextView.frame.origin.y + answerInputTextView.frame.height + keyboardHeight - tabBarHieght + margin
    }
    
    func keyboardWillShow(notification:NSNotification) { // キーボード更新時に高さを取得, scrollViewの調整
        let userInfo: NSDictionary = notification.userInfo!
        let keyboardFrame: NSValue = userInfo.valueForKey(UIKeyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.CGRectValue()
        keyboardHeight = keyboardRectangle.height
        
        scrollHeight = answerInputTextView.frame.origin.y + answerInputTextView.frame.height + keyboardHeight - tabBarHieght + margin
        answerInputScrollView.contentSize = CGSizeMake(self.view.frame.size.width, scrollHeight)
        setScrollPositionBottom()
    }
    
    func setScrollPositionBottom() {
        let positionY = answerInputScrollView.contentSize.height - answerInputScrollView.frame.size.height
        if positionY > 0 {
            answerInputScrollView.setContentOffset(CGPointMake(0, positionY), animated: false)
        }
    }
    
    func inputDone() {
        performSegueWithIdentifier("toAnswerConfirmVC", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toAnswerConfirmVC" {
            let nextVC = segue.destinationViewController as! AnswerConfirmViewController
            nextVC.selectedIndex = self.selectedIndex
            nextVC.selectedQuestion = self.selectedQuestion
            nextVC.answerText = self.answerInputTextView.text
        }
    }
    
}

extension AnswerInputViewController: UITextViewDelegate {
    func textViewDidChange(textView: UITextView) {
        if textView.tag == 2 { // answerInputTextViewが変更された時
            adjsutAnswerInputTextViewHeight()
            answerInputScrollView.contentSize = CGSizeMake(self.view.frame.size.width, scrollHeight)
            setScrollPositionBottom()
        }
    }
    
    
}


