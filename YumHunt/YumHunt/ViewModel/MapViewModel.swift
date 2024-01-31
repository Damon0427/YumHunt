
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var location: CLLocation?
    @Published var locationIsLoaded = false

    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization() //ask for permission
        self.locationManager.startUpdatingLocation()
    }
    

    func locationManagerDidChangeAuthorization( _ manager: CLLocationManager) {
        switch manager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            locationIsLoaded = false
            break
        case .restricted:
            print("Your location is restricted likely due to parental controls")
            break
        case .denied:
            print("You have denied this app location permission. Go to setting and Turn on location service")
        case .authorizedAlways, .authorizedWhenInUse:
            locationIsLoaded = true
            locationManager.startUpdatingLocation()
        @unknown default:
            locationIsLoaded = false
        }
        
    }
    
    
    func locationManager( _ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
            self.location = location
            manager.stopUpdatingLocation()//only need location once 
    }
}
    
