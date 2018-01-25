import UIKit
import GoogleMaps

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var findAddress: UIBarButtonItem!
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var viewMap: GMSMapView!
    
    var locationManager = CLLocationManager()
    var didFindMyLocation = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        //observe for changes in the myLocation property of the viewMap object.
        viewMap.addObserver(self, forKeyPath: "myLocation", options: NSKeyValueObservingOptions.new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if !didFindMyLocation {
            let myLocation: CLLocation = change![NSKeyValueChangeKey.newKey] as! CLLocation
            viewMap.camera = GMSCameraPosition.camera(withTarget: myLocation.coordinate, zoom: 10.0)
            viewMap.settings.myLocationButton = true
            didFindMyLocation = true
        }
    }
    
    
     // MARK: IBAction method implementation
    @IBAction func changeMapType(sender: AnyObject) {
        let actionSheet = UIAlertController(title:"Map Types", message: "Select map type", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let normalMapTypeAction = UIAlertAction(title:"Normal", style: UIAlertActionStyle.default) {
            (alertAction) -> Void in self.viewMap.mapType = .normal
        }
        
        let terrainMapTypeAction = UIAlertAction(title:"Terrain", style: UIAlertActionStyle.default) {
            (alertAction) -> Void in self.viewMap.mapType = .terrain
        }
        
        let hybridMapTypeAction = UIAlertAction(title:"Hybrid", style: UIAlertActionStyle.default) {
            (alertAction) -> Void in self.viewMap.mapType = .hybrid
        }
        
        let cancelAction = UIAlertAction(title:"Close", style: UIAlertActionStyle.cancel) {
            (alertAction) -> Void in
        }        
        
        actionSheet.addAction(normalMapTypeAction)
        actionSheet.addAction(terrainMapTypeAction)
        actionSheet.addAction(hybridMapTypeAction)
        actionSheet.addAction(cancelAction)
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    private func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedWhenInUse {
            viewMap.isMyLocationEnabled = true
        }
    }
}


