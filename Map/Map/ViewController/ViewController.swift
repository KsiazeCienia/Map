//
//  ViewController.swift
//  Map
//
//  Created by Marcin on 15.06.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    let pinProvider = PinProvider()
    var pins = [Pin]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
  
        
        pinProvider.getPinsFromAPI(lng: 2.2, lat: 2.2, succesHandler: { [weak self] (pins) in
            if let actualPins = pins {
                self?.pins = actualPins
            } else {
                //TODO: Show alert
            }
            
        }) { [weak self] (error) in
            //TODO: SHOW API ALER ERRO
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK:- TODO co w wypadku błedu
    
}

