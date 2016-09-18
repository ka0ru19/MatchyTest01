//
//  SearchSelectViewController.swift
//  MatchyTest01
//
//  Created by 井上航 on 2016/09/12.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit

class SearchSelectViewController: UIViewController {
    
    @IBOutlet weak var searchSelectTableView: UITableView!
    
    var selectArray = [String]()
    
    var selectedModel = SearchModel()
    
    var isSelected = [Bool]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        searchSelectTableView.delegate = self
        searchSelectTableView.dataSource = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension SearchSelectViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedModel.selectionList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = selectedModel.selectionList[indexPath.row].selectionName
        cell.accessoryType = .None
        cell.selectionStyle = .None
        
        if selectedModel.selectionList[indexPath.row].isSelected {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            if cell.accessoryType == .None {
                selectedModel.selectionList[indexPath.row].isSelected = true
                cell.accessoryType = .Checkmark
            } else {
                selectedModel.selectionList[indexPath.row].isSelected = false
                cell.accessoryType = .None
            }
            //            cell.setHighlighted(false, animated: true)
        }
    }
//    func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        //        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
//        //            cell.setHighlighted(false, animated: true)
//        //        }
//        return true
//    }
//    
//    func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
//        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
//            cell.setHighlighted(false, animated: false)
//        }
//    }
}