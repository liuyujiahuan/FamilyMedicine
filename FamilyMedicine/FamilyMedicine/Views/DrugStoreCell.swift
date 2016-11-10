//
//  DrugStoreCell.swift
//  FamilyMedicine
//
//  Created by 大欢 on 16/10/20.
//  Copyright © 2016年 大欢. All rights reserved.
//

import UIKit

class DrugStoreCell: UITableViewCell {

    static let reuseIdentifier = "DrugStoreCell"

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    func configureWithDrugStore(store:DrugStoreModel) {
        
        numberLabel.text = store.number
        nameLabel.text = store.name
        addressLabel.text = store.address
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        numberLabel.layer.cornerRadius = 10
        numberLabel.layer.masksToBounds = true
    }
}
