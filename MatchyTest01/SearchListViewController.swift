//
//  SearchListViewController.swift
//  MatchyTest01
//
//  Created by 井上航 on 2016/09/11.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit

class SearchListViewController: UIViewController {
    
    @IBOutlet weak var searchListTableView: UITableView!
    
    let searchSectionListArray = ["キーワード","文理","専攻","部活","恋愛","趣味、特技","就職","夢"]
    let sampleSpecialtyArray = ["電気","電子","情報","物理"] // 専攻のselectionNameList
    var searchModelArray = [SearchModel]()
    var searchListArray = [[String]]()
    
    var selectedIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        searchListTableView.delegate = self
        searchListTableView.dataSource = self
        searchListTableView.registerNib(UINib(nibName: "SearchListSelectedTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchSelectedCell")
        searchListTableView.registerNib(UINib(nibName: "SearchTextTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchWordCell")
        
        let clearView:UIView = UIView(frame: CGRectZero)
        clearView.backgroundColor = UIColor.clearColor()
        searchListTableView.tableFooterView = clearView
//        searchListTableView.tableHeaderView = clearView
        
        initSearchListArray()
    }
    
    override func viewWillAppear(animated: Bool) {
        searchListTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toSearchSelectVC" {
            let nextVC = segue.destinationViewController as! SearchSelectViewController
            nextVC.selectedModel = searchModelArray[selectedIndex]
        }
    }
    
    func initSearchListArray() {
        searchModelArray = []
        for i in 0 ..< searchSectionListArray.count {
            let model = SearchModel()
            model.sectionName = searchSectionListArray[i]
            
            if i == 2 {
                for item in sampleSpecialtyArray {
                    let selectionModel = SelectionModel()
                    selectionModel.selectionName = item
                    model.selectionList.append(selectionModel)
                }
            }
            searchModelArray.append(model)
        }
    }
}

extension SearchListViewController: UITableViewDelegate, UITableViewDataSource {
    
    // セクションの数を返す.
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return searchModelArray.count //searchSectionListArray.count
    }
    
    // セクションのタイトルを返す
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return searchModelArray[section].sectionName //searchSectionListArray[section]
    }
    
    // セクションの高さを指定
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    // cellの高さを指定
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 36
    }
    
    // Cellが選択された際に呼び出される. キーワードのcellはclassにより選択不能
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section != 0 {
            selectedIndex = indexPath.section
            performSegueWithIdentifier("toSearchSelectVC", sender: nil)
        }
    }
    
    // テーブルに表示する配列の総数を返す.
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchModelArray[section].isSelectedSomeSelection() == false {
            return 1
        } else {
            var numOfIsSelected = 0
            for selectionList in searchModelArray[section].selectionList {
                if selectionList.isSelected {
                    numOfIsSelected += 1
                }
            }
            return numOfIsSelected
        }
        
    }
    
    // Cellに値を設定する.
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 { // キーワードのセクション
            let cell = tableView.dequeueReusableCellWithIdentifier("SearchWordCell", forIndexPath: indexPath) as! SearchTextTableViewCell
            if searchModelArray[0].searchText == nil { // キーワードが無記入のとき
                cell.initWordCell()
            } else { // キーワードがすでに入力されているとき
                cell.setWordCell(searchModelArray[0].searchText!)
            }
            return cell
            
        } else { // キーワード以外のセクション
            let cell = tableView.dequeueReusableCellWithIdentifier("SearchSelectedCell", forIndexPath: indexPath) as! SearchListSelectedTableViewCell
            
            if searchModelArray[indexPath.section].isSelectedSomeSelection() == false {
                // 未選択の時
                cell.initSelectCell()
            } else {
                // 2-1. インスタンス化するタイミングでdelegateをset
                cell.removeSelectedSelectionDelegate = self
                cell.setSelectCell(
                    searchModelArray[indexPath.section].getSelectedSelectionAtIndex(indexPath.row),
                    section: indexPath.section,
                    row: indexPath.row)
            }
            return cell
        }
    }
    
}

// 2-2.任意のquestionをtableviewから削除するのに使う
extension SearchListViewController: RemoveSelectedSelectionDelegate {
    func removeSelectedSelection(section section: Int, row: Int) {
        searchModelArray[section].setSelectedFalseAtIndex(row)
        searchListTableView.reloadData()
    }
}