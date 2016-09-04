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
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var answerInputTextView: UITextView!
    
    var personImageName: String!
    var detailQuestionText: String!
    
    let margin: CGFloat = 8.0 // パーツ間の余白
    var scrollHeight: CGFloat!
    var keyboardHeight: CGFloat = 0
    
    let tabBarHieght = UITabBarController().tabBar.frame.size.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 横スクロールの禁止を設定する
        
        questionTextView.delegate = self
        answerInputTextView.delegate = self
        
        questionTextView.editable = false
        answerInputTextView.editable = true
        
        questionTextView.scrollEnabled = false
        answerInputTextView.scrollEnabled = false
        
        questionTextView.tag = 1
        answerInputTextView.tag = 2
        
        answerInputTextView.layer.masksToBounds = true
        answerInputTextView.layer.cornerRadius = 8.0
        answerInputTextView.layer.borderWidth = 1
        answerInputTextView.layer.borderColor = UIColor.blackColor().CGColor
        
        // Do any additional setup after loading the view.
        displayUIPartsContents()
        adjsutQuestionTextViewHeight()
        adjsutAnswerInputTextViewHeight()
        answerInputScrollView.contentSize = CGSizeMake(self.view.frame.size.width, scrollHeight)
        // 最後にスクロールビューの範囲を設定
        
        let doneNavigationButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "inputDone")
        navigationItem.rightBarButtonItem = doneNavigationButton
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        
    }
    
    func keyboardWillShow(notification:NSNotification) {
        let userInfo:NSDictionary = notification.userInfo!
        let keyboardFrame:NSValue = userInfo.valueForKey(UIKeyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.CGRectValue()
        keyboardHeight = keyboardRectangle.height
        print(keyboardHeight)
        scrollHeight = answerInputTextView.frame.origin.y + answerInputTextView.frame.height + keyboardHeight - tabBarHieght + margin
        answerInputScrollView.contentSize = CGSizeMake(self.view.frame.size.width, scrollHeight)
        self.answerInputScrollView.setContentOffset(
            CGPointMake(
                0, self.answerInputScrollView.contentSize.height - self.answerInputScrollView.frame.size.height
            ), animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func inputDone() {
        print("doneeeee")
    }
    
    func displayUIPartsContents() {
        questionerIconImageView.image = UIImage(named: personImageName)
        questionerNameLabel.text = personImageName
        questionerTascaLabel.text = "12345タスカ"
        questionTextView.text = detailQuestionText
    }
    
    func adjsutQuestionTextViewHeight() { // 最初に一回だけ呼ばれる
        questionTextView.backgroundColor = UIColor.cyanColor()
        let fixedWidth = questionTextView.frame.size.width
        let newSize = questionTextView.sizeThatFits(CGSizeMake(fixedWidth, CGFloat.max))
        var newFrame = questionTextView.frame
        newFrame.size = CGSizeMake(max(newSize.width, fixedWidth), newSize.height)
        print(newFrame)
        questionTextView.frame = newFrame
        
        // 下のUIPartsに高さを引き継ぐ
        answerInputTextView.frame.origin.y = newFrame.origin.y + newFrame.size.height + margin
        
        view.setNeedsLayout()
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
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension AnswerInputViewController: UITextViewDelegate {
    func textViewDidChange(textView: UITextView) {
        if textView.tag == 2 { // answerInputTextViewが変更された時
            adjsutAnswerInputTextViewHeight()
            answerInputScrollView.contentSize = CGSizeMake(self.view.frame.size.width, scrollHeight)
            self.answerInputScrollView.setContentOffset(
                CGPointMake(
                    0, self.answerInputScrollView.contentSize.height - self.answerInputScrollView.frame.size.height
                ), animated: false)
        }
    }
}


