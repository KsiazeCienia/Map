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

final class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    private let locationManager = CLLocationManager()
    private let pinProvider = PinProvider()
    private let dataBase = DataBase()
    
    fileprivate var userLocation = CLLocation()
    private var pins = [Pin]()
    private var selectedPin: Pin?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMap()
        askForPermisionOrRequestLocation()
    }
    
    private func setUpMap() {
        locationManager.delegate = self
        mapView.delegate = self
        mapView.showsUserLocation = true
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
            //MARK:-TODO usunać potem bo do testów
            for pin in dataBase.getData() {
                print(pin.id)
            }
        }
    }
}

extension MapViewController: CLLocationManagerDelegate, MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let pointAnnontation = view.annotation as? Annotation {
            performSegue(withIdentifier: Segue.goToSinglePlaceFromMap, sender: pointAnnontation)
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

