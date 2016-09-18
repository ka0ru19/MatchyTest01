//
//  SearchModel.swift
//  MatchyTest01
//
//  Created by 井上航 on 2016/09/12.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import Foundation

class SearchModel {
    var sectionName: String! // 項目名
    var selectionList = [SelectionModel]() // 選択肢
    //    var selectedNameList = [String]?() // 選択済
    var searchText: String?
    
    func isSelectedSomeSelection() -> Bool {
        for selection in selectionList {
            if selection.isSelected == true {
                return true
            }
        }
        return false
    }
    
    // n番目のselectionList.trueのselectionList.selectionNameを取得する関数
    func getSelectedSelectionAtIndex(index: Int) -> String {
        var selectedSelectionCount: Int = 0
        for selection in selectionList {
            if selection.isSelected == true {
                if selectedSelectionCount == index {
                    return selection.selectionName
                } else {
                    selectedSelectionCount += 1
                }
            }
        }
        fatalError() // 起き得ない
    }
    
    // index番目のselectionList.trueをfalseに変更する関数
    func setSelectedFalseAtIndex(index: Int) {
        var selectedSelectionCount: Int = 0
        for selection in selectionList {
            if selection.isSelected == true {
                if selectedSelectionCount == index {
                    selection.isSelected = false
                    return
                } else {
                    selectedSelectionCount += 1
                }
            }
        }
        fatalError() // 起き得ない
    }
}

class SelectionModel {
    var selectionName: String!
    var isSelected = false
}