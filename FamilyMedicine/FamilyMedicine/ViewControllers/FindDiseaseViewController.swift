//
//  FindDiseaseViewController.swift
//  FamilyMedicine
//
//  Created by 大欢 on 16/10/18.
//  Copyright © 2016年 大欢. All rights reserved.
//

import UIKit

class FindDiseaseViewController: UITableViewController {

    lazy var datalist:[DiseaseModel]! = {
    
        return DiseaseModel.loadData()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension FindDiseaseViewController {
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return datalist.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        let disease = datalist[section]
        return disease.value.count
    }
    

     override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(FindDiseaseCell.reuseIdentifier, forIndexPath: indexPath) as! FindDiseaseCell
     
        let disease = datalist[indexPath.section]
        
        cell.diseaseLabel.text = disease.value[indexPath.row]
        cell.diseaseDescLabel.text = disease.desc[indexPath.row]

        return cell
        
     }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let disease = datalist[section]
        return disease.key
    }
    
}

