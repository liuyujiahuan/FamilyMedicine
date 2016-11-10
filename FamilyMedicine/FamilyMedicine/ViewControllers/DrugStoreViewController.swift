//
//  DrugStoreViewController.swift
//  FamilyMedicine
//
//  Created by 大欢 on 16/10/19.
//  Copyright © 2016年 大欢. All rights reserved.

// http://api.map.baidu.com/place/v2/search?ak=EiC8jcCLM6XmxmGHRTzjAUFz&location=40.0919638990797,116.419451431323&mcode=cn.dxy.aspirinpro&output=json&page_size=20&query=药店$医院&卫生院&radius=2000&tag=药店

//http://dxy.com/app/i/feed/index/list?ac=1d6c96d5-9a53-4fe1-9537-85a33de916f1

import UIKit
import MapKit
import Alamofire

class DrugStoreViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var datalist :[DrugStoreModel] = [] {
        
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var manager: CLLocationManager = {
        
        let manager = CLLocationManager.init()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
        return manager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //获取定位权限
        guard CLLocationManager.locationServicesEnabled() else { return }
        
        let status = CLLocationManager.authorizationStatus()
        if status == .NotDetermined {
            manager.requestWhenInUseAuthorization()
        }
        
        //获取附近的药店
        FamilyMedicineAPI.sharedInstance.getNearDrugStore { (drugs) in
            
            for (index,drug) in drugs.enumerate() {
                drug.number = "\(index + 1)"
            }
            
            self.datalist = drugs
            
            //药店经纬度绘制大头针
            for drug in drugs {
                
                let lat = drug.location["lat"] as? Double
                let lng = drug.location["lng"] as? Double

                let pin = SXTAnnotation()
                pin.coordinate = CLLocationCoordinate2D(latitude:lat!, longitude: lng!)
                pin.title = drug.name
                pin.subtitle = drug.address
                pin.number = drug.number
                self.mapView.addAnnotation(pin)
                
            }
            
        }
    }
}

extension DrugStoreViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return datalist.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(DrugStoreCell.reuseIdentifier, forIndexPath: indexPath) as! DrugStoreCell
        
        let drugStore = datalist[indexPath.row]
        
        cell.configureWithDrugStore(drugStore)
        
        return cell
    }
}


extension DrugStoreViewController: MKMapViewDelegate {
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        
        let coor = userLocation.coordinate
        mapView.setCenterCoordinate(coor, animated: true)
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let region = MKCoordinateRegion(center: coor, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation.isKindOfClass(MKUserLocation) { return nil }
        
        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier("reuseIdentifier")
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: nil, reuseIdentifier: "reuseIdentifier")
            annotationView?.canShowCallout = true
            annotationView?.rightCalloutAccessoryView  = UIButton(type: .DetailDisclosure)
        }

        let ann = annotation as! SXTAnnotation
        annotationView?.image = drawNumberOnImage(ann.number!)
        return annotationView
    }
    
    private func drawNumberOnImage(number:String) -> UIImage {
        
        let image = UIImage(named: "V5MapNear")!
        UIGraphicsBeginImageContextWithOptions(image.size, false, 0)
        image.drawAtPoint(CGPointZero)
        
        let attribute = [NSFontAttributeName:UIFont.systemFontOfSize(10),NSForegroundColorAttributeName:UIColor.whiteColor()]
        
        let idx = number as NSString
        let size = idx.sizeWithAttributes(attribute)
        let x = (image.size.width - size.width) / 2
        idx.drawAtPoint(CGPoint(x: x, y: 3), withAttributes:attribute)
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
}
