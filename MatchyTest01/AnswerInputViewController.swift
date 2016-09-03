//
//  AnswerInputViewController.swift
//  MatchyTest01
//
//  Created by 井上航 on 2016/09/03.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit

class AnswerInputViewController: UIViewController {

    @IBOutlet weak var questionerIconImageView: UIImageView!
    @IBOutlet weak var questionerNameLabel: UILabel!
    @IBOutlet weak var questionerTascaLabel: UILabel!
    @IBOutlet weak var questionTextView: UITextView!
    
    var personImageName: String!
    var detailText: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        display()
        let doneNavigationButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "inputDone")
        navigationItem.rightBarButtonItem = doneNavigationButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func inputDone() {
        print("doneeeee")
    }

    func display() {
        questionerIconImageView.image = UIImage(named: personImageName)
        questionerNameLabel.text = personImageName
        questionerTascaLabel.text = "12345タスカ"
        questionTextView.text = detailText
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
