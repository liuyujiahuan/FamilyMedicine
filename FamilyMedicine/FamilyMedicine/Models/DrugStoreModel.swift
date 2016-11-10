//
//  DrugStoreModel.swift
//  FamilyMedicine
//
//  Created by 大欢 on 16/10/19.
//  Copyright © 2016年 大欢. All rights reserved.
//

/*
 
 {
 "name":"芳雪天通大药房",
 "location":{
 "lat":40.084908,
 "lng":116.417699
 },
 "address":"天通西苑三区26",
 "street_id":"a12baa40e109d956e856fa62",
 "telephone":"(010)64112678",
 "detail":1,
 "uid":"a12baa40e109d956e856fa62"
 },
 
 */


import UIKit


class DrugStoreModel: NSObject {

    var name: String = ""
    var address: String = ""
    var telephone: String?
    var location: [String: AnyObject] = [:]
    
    var number:String?
    
    init(dict : [String : AnyObject]) {
        super.init()
        
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
}
