//
//  MapForLocationViewController.swift
//  Sprint2
//
//  Created by Capgemini-DA073 on 9/27/22.
//

import UIKit
import MapKit
import CoreLocation

class MapForLocationViewController: UIViewController, CLLocationManagerDelegate{    //Class for displaying Users Location begins.

    
    @IBOutlet weak var ConfirmOrderButton: UIButton!
    
    @IBOutlet weak var userLocationMapView: MKMapView!
    
    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        manager.requestWhenInUseAuthorization()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
    }
   
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first{
            manager.stopUpdatingLocation()
            
            render(location)
        }
    }
    
        func render(_ location: CLLocation){                 //Function to zoom in the map.

        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
            userLocationMapView.setRegion(region, animated: true)
        
        
       
        let pin = MKPointAnnotation()                       //Annotation Part
        pin.coordinate = coordinate
            userLocationMapView.addAnnotation(pin)
    }
    
    static func getVC() -> MapForLocationViewController{
            let storyBoard = UIStoryboard(name:"Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "MapForLocationViewController") as! MapForLocationViewController
            return vc
            }
}                                                          //Class for displaying Users Location begins.
