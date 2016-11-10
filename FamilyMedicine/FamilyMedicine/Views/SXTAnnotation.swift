//
//  SXTAnnotation.swift
//  FamilyMedicine
//
//  Created by 大欢 on 16/10/20.
//  Copyright © 2016年 大欢. All rights reserved.
//

import UIKit
import MapKit

class SXTAnnotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D()
    
    var title: String?
    var subtitle: String?
    
    var number: String?
    
}
