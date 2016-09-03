//
//  QuestionDetailViewController.swift
//  MatchyTest01
//
//  Created by 井上航 on 2016/09/03.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit

class QuestionDetailViewController: UIViewController {

    @IBOutlet weak var questionerIconImageView: UIImageView!
    @IBOutlet weak var questionerNameLabel: UILabel!
    @IBOutlet weak var questionerTascaLabel: UILabel!
    @IBOutlet weak var questionTextView: UITextView!
    
    var selectedPersonImageName: String!
    var selectedDetailText: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        questionTextView.scrollEnabled = false
        
        display()
        adjsutTextViewHeight()
        
    }
    
    override func viewDidLayoutSubviews() {
//        let fixedWidth = questionTextView.frame.size.width
//        let newSize = questionTextView.sizeThatFits(CGSizeMake(fixedWidth, CGFloat.max))
//        var newFrame = questionTextView.frame
//        newFrame.size = CGSizeMake(max(newSize.width, fixedWidth), newSize.height)
//        questionTextView.frame = newFrame
//        
//        view.reloadInputViews()
    }
    
    

    func adjsutTextViewHeight() {
        questionTextView.backgroundColor = UIColor.cyanColor()
        let fixedWidth = questionTextView.frame.size.width
        let newSize = questionTextView.sizeThatFits(CGSizeMake(fixedWidth, CGFloat.max))
        var newFrame = questionTextView.frame
        newFrame.size = CGSizeMake(max(newSize.width, fixedWidth), newSize.height)
        questionTextView.frame = newFrame
        
        view.setNeedsLayout()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func display() {
        questionerIconImageView.image = UIImage(named: selectedPersonImageName)
        questionerNameLabel.text = selectedPersonImageName
        questionerTascaLabel.text = "12345タスカ"
        questionTextView.text = selectedDetailText
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
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
            nextVC.detailText = selectedDetailText
        }
    }

}


