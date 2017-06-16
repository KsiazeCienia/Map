import Foundation
import CoreLocation

final class LocalizationHandler: NSObject {
    
    static let shared = LocalizationHandler()
    
    var completion:((_ localization:CLLocation) -> ())?
    var permissionsCompletion:(() ->())?
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    let locationManager = CLLocationManager()
    
    var lastLocation:CLLocation?
    

    func askForPermissions(completion:(() -> ())?) {
        self.permissionsCompletion = completion
        locationManager.requestWhenInUseAuthorization()
    }
    
    static func available() -> Bool{
        return CLLocationManager.authorizationStatus() == .authorizedAlways || CLLocationManager.authorizationStatus() == .authorizedWhenInUse
    }
    
    static func permissionNotDetermined() -> Bool {
        return CLLocationManager.authorizationStatus() == .notDetermined
    }
    
    func getLocalization(completion:((_ localization:CLLocation) -> ())?) {
        self.completion = completion
        locationManager.requestLocation()
    }
    
    static func distance(coordinates:CLLocationCoordinate2D) -> CLLocationDistance {
        if let coordinate1 = shared.lastLocation {
            let coordinate2 = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
            return coordinate1.distance(from: coordinate2) * 0.000621371192 //meters to miles
        }
        return 0.0
    }
    
}

extension LocalizationHandler: CLLocationManagerDelegate {
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.lastLocation = locations.first
        if let loc = locations.first, let comp = completion {
            comp(loc)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            locationManager.requestLocation()
            if let pc = permissionsCompletion {
                pc()
            }          
        }
    }
    
    
}
