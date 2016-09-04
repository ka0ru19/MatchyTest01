//
//  QuestionDetailViewController.swift
//  MatchyTest01
//
//  Created by 井上航 on 2016/09/03.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit

class QuestionDetailViewController: UIViewController {
    
    @IBOutlet weak var questionScrollView: UIScrollView!
    
    @IBOutlet weak var questionerIconImageView: UIImageView!
    @IBOutlet weak var questionerNameLabel: UILabel!
    @IBOutlet weak var questionerTascaLabel: UILabel!
    @IBOutlet weak var questionTextView: UITextView!
    
    @IBOutlet weak var answerRefuseButton: UIButton!
    @IBOutlet weak var answerInputButton: UIButton!
    
    var selectedPersonImageName: String!
    var selectedDetailText: String!
    
    let margin: CGFloat = 8.0 // パーツ間の余白
    var scrollHeight: CGFloat!
    var buttonStartY: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionTextView.delegate = self
        questionTextView.editable = false // テキスト編集可能性
        questionTextView.scrollEnabled = false
        questionTextView.font = UIFont.systemFontOfSize(CGFloat(14))
        
        // とりあえずの設定
        questionScrollView.contentSize = CGSizeMake(self.view.frame.size.width, 1200)
        
        displayUIPartsContents()
        adjsutTextViewHeight()
        adjsutButtonStartY()
        adjsutScrollViewHeight()
    }
    
    func adjsutTextViewHeight() {
        questionTextView.backgroundColor = UIColor.cyanColor()
        let fixedWidth = questionTextView.frame.size.width
        let newSize = questionTextView.sizeThatFits(CGSizeMake(fixedWidth, CGFloat.max))
        var newFrame = questionTextView.frame
        newFrame.size = CGSizeMake(max(newSize.width, fixedWidth), newSize.height)
        print(newFrame)
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayUIPartsContents() {
        questionerIconImageView.image = UIImage(named: selectedPersonImageName)
        questionerNameLabel.text = selectedPersonImageName
        questionerTascaLabel.text = "12345タスカ"
        questionTextView.text = selectedDetailText
    }
    
    @IBAction func onTappedAnswerInput(sender: UIButton) {
        performSegueWithIdentifier("toAnswerInputVC", sender: nil)
    }
    
    @IBAction func onTappedAnswerRefuse(sender: UIButton) {
        // アラートを表示
        // cellからこの質問を削除
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toAnswerInputVC" {
            let nextVC = segue.destinationViewController as! AnswerInputViewController
            nextVC.personImageName = selectedPersonImageName
            nextVC.detailQuestionText = selectedDetailText
        }
    }
    
}

extension QuestionDetailViewController: UITextViewDelegate {
    func textViewDidChange(textView: UITextView) {
        adjsutTextViewHeight()
        adjsutButtonStartY()
        adjsutScrollViewHeight()
    }
    
}


