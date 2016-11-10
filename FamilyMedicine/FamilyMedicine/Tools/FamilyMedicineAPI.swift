//
//  FamilyMedicineAPI.swift
//  FamilyMedicine
//
//  Created by 大欢 on 16/10/20.
//  Copyright © 2016年 大欢. All rights reserved.
//

import Foundation
import Alamofire

class FamilyMedicineAPI {
    
    static let sharedInstance = FamilyMedicineAPI()
    
    private let apiBaseURL = "http://dxy.com/app/i/feed/index/list?ac=1d6c96d5-9a53-4fe1-9537-85a33de916f1"
    
    private let mapURL = "http://api.map.baidu.com/place/v2/search"
    
    func getNearDrugStore(completion:[DrugStoreModel]->Void) {
        
        let params = ["ak":"EiC8jcCLM6XmxmGHRTzjAUFz","location":"40.0919638990797,116.419451431323","mcode":"cn.dxy.aspirinpro","output":"json","page_size":20,"query":"药店$医院&卫生院","radius":2000,"tag":"药店"]
        
        requestData(mapURL, method: "get", parameters: params) { (JSON) in
            
            var models: [DrugStoreModel] = []
            
            if let result = JSON as? [String:AnyObject] {
                let dictArray = result["results"] as! [[String:AnyObject]]
                for dict in dictArray {
                    models.append(DrugStoreModel(dict: dict))
                }
                completion(models)
            }
        }

    }
    
    private func requestData(subURL:String, method:String, parameters:[String:AnyObject]?, completion:AnyObject? -> Void) {
        
        let requestMethod = method == "get" ? Method.GET : Method.POST
        
        Alamofire.request(requestMethod, subURL, parameters: parameters).responseJSON { (response) in
            
            switch response.result {
                
            case .Success(let JSON):
                    completion(JSON)
            case .Failure(let error):
                print("request failed with error:\(error)")
            }
        }
    }
    
}