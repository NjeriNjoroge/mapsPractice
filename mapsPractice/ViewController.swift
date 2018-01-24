import UIKit
import GoogleMaps

class ViewController: UIViewController {
    
    @IBOutlet weak var findAddress: UIBarButtonItem!
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var viewMap: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: 48.857165, longitude: 2.354613, zoom: 8.0)
        viewMap.camera = camera
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

}


