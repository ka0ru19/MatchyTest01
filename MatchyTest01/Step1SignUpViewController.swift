//
//  Step1SignUpViewController.swift
//  MatchyTest01
//
//  Created by 井上航 on 2016/09/18.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit

class Step1SignUpViewController: UIViewController {
    
    @IBOutlet weak var theInputView: UIView!
    @IBOutlet weak var topLabelInTheView: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var guideOfFacebookLabel: UILabel!

    var keyboardHeight: CGFloat!
    let theViewStartY: CGFloat = 90
    var theViewHeight: CGFloat!

    override func viewDidLoad() {
        super.viewDidLoad()

        let fixedWidth = theInputView.frame.size.width
        let newSize = theInputView.sizeThatFits(CGSizeMake(fixedWidth, CGFloat.max))
        var newFrame = theInputView.frame
        newFrame.size = CGSizeMake(max(newSize.width, fixedWidth), newSize.height)
        print(newFrame)
        theInputView.frame = newFrame

        
//        initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func adjsutTextViewHeight() {
//        let fixedWidth = questionTextView.frame.size.width
//        let newSize = questionTextView.sizeThatFits(CGSizeMake(fixedWidth, CGFloat.max))
//        var newFrame = questionTextView.frame
//        newFrame.size = CGSizeMake(max(newSize.width, fixedWidth), newSize.height)
//        questionTextView.frame = newFrame
//        
//        // 下のUIPartsに高さを引き継ぐ
//        scrollHeight = newFrame.origin.y + newFrame.size.height + margin
//        
//        view.setNeedsLayout()
    }


    func initView() {
        let screenWidth = view.bounds.width
        let screenHeight = view.bounds.height
        keyboardHeight = screenWidth / 320 * 252
        theViewHeight = screenHeight - theViewStartY
        let margin = ( theViewHeight
            - topLabelInTheView.frame.height
            - nameTextField.frame.height
            - mailTextField.frame.height
            - passTextField.frame.height
            - guideOfFacebookLabel.frame.height
            - keyboardHeight ) / CGFloat(7)
        
        theInputView.frame = CGRect(x: 0, y: theViewStartY, width: screenWidth, height: theViewHeight)
        theInputView.center.x = view.center.x
        view.addSubview(theInputView)
        theInputView.setNeedsLayout()
        var nextStartY = theViewStartY + margin
        print(nextStartY)
        
        
        
//        theInputView.bounds = CGRect(x: 0, y: theViewStartY, width: screenWidth, height: theViewHeight)
//        theInputView.center.x = view.center.x
//        var nextStartY = theViewStartY + margin
//        print(nextStartY)
//        
//        var viewSize = topLabelInTheView.bounds.size
//        topLabelInTheView.bounds = CGRect(x: 0, y: nextStartY, width: viewSize.width, height: viewSize.height)
//        topLabelInTheView.center.x = view.center.x
//        nextStartY += viewSize.height + margin
//        print(nextStartY)
//        
//        viewSize = nameTextField.bounds.size
//        nameTextField.bounds = CGRect(x: 0, y: nextStartY, width: viewSize.width, height: viewSize.height)
//        nameTextField.center.x = view.center.x
//        nextStartY += viewSize.height + margin
//        print(nextStartY)
//        
//        viewSize = mailTextField.bounds.size
//        mailTextField.bounds = CGRect(x: 0, y: nextStartY, width: viewSize.width, height: viewSize.height)
//        mailTextField.center.x = view.center.x
//        nextStartY += viewSize.height + margin
//        print(nextStartY)
//        
//        viewSize = passTextField.bounds.size
//        passTextField.bounds = CGRect(x: 0, y: nextStartY, width: viewSize.width, height: viewSize.height)
//        passTextField.center.x = view.center.x
//        nextStartY += viewSize.height + margin
//        print(nextStartY)
//        
//        viewSize = guideOfFacebookLabel.bounds.size
//        guideOfFacebookLabel.bounds = CGRect(x: 0, y: nextStartY, width: viewSize.width, height: viewSize.height)
////        guideOfFacebookLabel.center.x = view.center.x
//        nextStartY += viewSize.height + margin
//        print(nextStartY)
//        
//        theInputView.addSubview(topLabelInTheView)
//        theInputView.addSubview(nameTextField)
//        theInputView.addSubview(mailTextField)
//        theInputView.addSubview(passTextField)
//        theInputView.addSubview(guideOfFacebookLabel)
        
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
