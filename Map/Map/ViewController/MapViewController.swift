//
//  ViewController.swift
//  Map
//
//  Created by Marcin on 15.06.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class Annotation: MKPointAnnotation {
    var id: Int?
    
    init(id: Int, coordinate: CLLocationCoordinate2D, title: String) {
        super.init()
        self.id = id
        self.coordinate = coordinate
        self.title = title
    }
}

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    let pinProvider = PinProvider()
    let dataBase = DataBase()
    
    var userLocation = CLLocation()
    var pins = [Pin]()
    var selectedPin: Pin?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        mapView.delegate = self
        askForPermisionOrRequestLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    fileprivate func downloadPins(withLng lng: Double, withLat lat: Double) {
        pinProvider.getPinsFromAPI(lng: lng, lat: lat, succesHandler: { [weak self] (pins) in
            if let actualPins = pins {
                self?.pins = actualPins
                self?.setPins()
                self?.setUpRegion()
            } else {
                //TODO: Show alert
            }
            
        }) { (error) in
            //TODO: SHOW API ALER ERRO
        }
    }
   
    private func setUpRegion() {
        var distances = [Double]()
        
        for pin in pins {
            let distanceFromUser = sqrt(abs(pow(userLocation.coordinate.latitude - pin.lat, 2)) + abs(pow(userLocation.coordinate.longitude-pin.lng, 2)))
            distances.append(distanceFromUser)
        }
        
        if let max = distances.max() {
            let span = MKCoordinateSpanMake(max + 0.02, max + 0.02)
            let userRegion = MKCoordinateRegion(center: userLocation.coordinate, span: span)
            mapView.setRegion(userRegion, animated: true)
        }
    }
    
    fileprivate func updateMapWithUserLocation(location: CLLocation) {
        let span = MKCoordinateSpanMake(MapKeys.latitudeDelta, MapKeys.longitudeDelta)
        let userRegion = MKCoordinateRegion(center: location.coordinate, span: span)
        mapView.setRegion(userRegion, animated: true)
    }
    
    private func setPins() {
        for pin in pins {
            let location = CLLocationCoordinate2D(latitude: CLLocationDegrees(pin.lat), longitude: CLLocationDegrees(pin.lng))
            let point = Annotation(id: pin.id, coordinate: location, title: pin.name)
            mapView.addAnnotation(point)
        }
    }
    
    private func askForPermisionOrRequestLocation() {
        let authorizationStatus:CLAuthorizationStatus = CLLocationManager.authorizationStatus()
        
        if authorizationStatus == CLAuthorizationStatus.denied {
            // TODO: Tell user that app functionality may be limited
        }
        else if authorizationStatus == CLAuthorizationStatus.notDetermined {
            self.locationManager.requestWhenInUseAuthorization()
        }
        else if authorizationStatus == CLAuthorizationStatus.authorizedWhenInUse {
            self.locationManager.requestLocation()
        }
    }
    
    private func pinWithId(id: Int) -> Pin {
        for i in 0 ..< pins.count {
            if (pins[i].id == id) {
                return pins[i]
            }
        }
        return pins[0]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let annotation = sender as? Annotation else { return }
        let singlePlaceVC = segue.destination as! SinglePlaceViewController
        if let actualId = annotation.id {
            singlePlaceVC.currentPin = pinWithId(id: actualId)
            dataBase.save(pin: pinWithId(id: actualId))
            for pin in dataBase.getData() {
                print(pin.id)
            }
        }
    }
}

extension MapViewController: CLLocationManagerDelegate, MKMapViewDelegate{
    
    
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        let reuseIdentifier = "MyIdentifier"
//        if annotation is MKUserLocation { return nil }
//
//        
//        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier) as? MKPinAnnotationView
//        if annotationView == nil {
//            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
//            annotationView?.canShowCallout = false            // but turn off callout
//        } else {
//            annotationView?.annotation = annotation
//        }
//        
//        return annotationView
//    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let pointAnnontation = view.annotation as? Annotation {
            performSegue(withIdentifier: Segue.goToSinglePlace, sender: pointAnnontation)
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        manager.delegate = nil
        
        if let location = locations.first {
            userLocation = location
            downloadPins(withLng: location.coordinate.longitude.magnitude, withLat: location.coordinate.latitude.magnitude)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.requestLocation()
        }
    }
}

