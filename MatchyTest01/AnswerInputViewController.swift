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
    @IBOutlet weak var separateYourAnswerLabel: UILabel!
    @IBOutlet weak var answerInputTextView: UITextView!
    
    var selectedQuestion = QuestionModel()
    var selectedIndex: Int!
    
    let margin: CGFloat = 8.0 // パーツ間の余白
    var scrollHeight: CGFloat!
    var keyboardHeight: CGFloat = 0
    
    let tabBarHieght = UITabBarController().tabBar.frame.size.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayUIPartsContents()
        setUpTextView()
        setUpQuestionTextViewHeight()
        setUpSeparateYourAnswerLabelPosition()
        adjsutAnswerInputTextViewHeight()
        
        
        let doneNavigationButton = UIBarButtonItem(title: "完了", style: .Done, target: self, action: "answerInputDone")
        navigationItem.rightBarButtonItem = doneNavigationButton
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        
    }
    
    func displayUIPartsContents() {
        questionerIconImageView.image = UIImage(data: selectedQuestion.questionerIconNSData)
        questionerNameLabel.text = selectedQuestion.questionerName
        separateYourAnswerLabel.text = "あなたの回答"
        answerInputTextView.text = ""
        
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
    
    func setUpTextView() {
        questionerNameLabel.font = UIFont.boldSystemFontOfSize(CGFloat(16))
        
        questionerTascaLabel.textAlignment = .Center
        
        questionTextView.delegate = self
        questionTextView.editable = false
        questionTextView.scrollEnabled = false
        questionTextView.tag = 1
        questionTextView.font = UIFont.systemFontOfSize(CGFloat(12))
        questionTextView.backgroundColor = MatchyColor.questionBackgroundColor
        
        separateYourAnswerLabel.font = UIFont.systemFontOfSize(CGFloat(10))
        separateYourAnswerLabel.textColor = UIColor.darkGrayColor()
        
        answerInputTextView.delegate = self
        answerInputTextView.editable = true
        answerInputTextView.scrollEnabled = false
        answerInputTextView.tag = 2
        answerInputTextView.layer.masksToBounds = true
        answerInputTextView.layer.cornerRadius = 6.0
        answerInputTextView.layer.borderWidth = 1
        answerInputTextView.layer.borderColor = UIColor.blackColor().CGColor
        
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
        separateYourAnswerLabel.frame.origin.y = newFrame.origin.y + newFrame.size.height + margin
    }
    
    func setUpSeparateYourAnswerLabelPosition() {
        view.setNeedsLayout()
        // 下のUIPartsに高さを引き継ぐ
        answerInputTextView.frame.origin.y =
            separateYourAnswerLabel.frame.origin.y + separateYourAnswerLabel.frame.size.height + margin
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
    
    func answerInputDone() {
        selectedQuestion.answerText = answerInputTextView.text
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


