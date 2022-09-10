//
//  ViewController.swift
//  userLocation
//
//  Created by Ruba on 13/02/1444 AH.
//

import CoreLocation
import UIKit
import MapKit

class ViewController: UIViewController , CLLocationManagerDelegate {

    let manager = CLLocationManager()
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let initialLocation = CLLocation(latitude: 24.774265, longitude: 46.738586)
        startingLocation(location: initialLocation, distance: 1000)
        addAnnotation()
    }

    func startingLocation(location : CLLocation , distance : CLLocationDistance){
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: distance, longitudinalMeters: distance)
        mapView.setRegion(region, animated: true)
        mapView.setCameraBoundary(MKMapView.CameraBoundary(coordinateRegion: region), animated: true)
        let zoom = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 30000)
        mapView.setCameraZoomRange(zoom, animated: true)
    }
    
    func addAnnotation(){
        let pin = MKPointAnnotation()
        pin.coordinate = CLLocationCoordinate2D(latitude: 24.774265, longitude: 46.738586)
        pin.title = "My Location"
        pin.subtitle = "Here i'm :)"
        mapView.addAnnotation(pin)
    }
}

