//
//  DiseaseModel.swift
//  FamilyMedicine
//
//  Created by 大欢 on 16/10/18.
//  Copyright © 2016年 大欢. All rights reserved.
//

import UIKit

class DiseaseModel: NSObject {

    var key: String //大标题
    var value: [String] //标题
    var desc: [String] //描述
    
    init(key: String, value: [String], desc: [String]) {
        
        self.key = key
        self.value = value
        self.desc = desc
    }
}

extension DiseaseModel {
    
    class func loadData() -> [DiseaseModel]? {
    
        var tempList:[DiseaseModel] = [];
        
        if let filePath = NSBundle.mainBundle().pathForResource("ProDiseases", ofType: "plist") {
        
            if let datalist = NSArray(contentsOfFile: filePath) as? [[String:AnyObject]]
            {
                for dict in datalist {
                    
                    let key = dict["key"] as! String
                    let value = dict["value"] as! [String]
                    let desc = dict["dec"] as! [String]
            
                    let disease = DiseaseModel(key: key, value: value, desc: desc)
    
                    tempList.append(disease)
                }
                
                return tempList
            }
        }
        return nil;
    }
}
