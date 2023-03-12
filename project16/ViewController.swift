//
//  ViewController.swift
//  project16
//
//  Created by Tamim Khan on 12/3/23.
//

import MapKit
import UIKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let dhaka = Capital(title: "Dhaka", coordinate: CLLocationCoordinate2D(latitude: 23.8103, longitude: 90.4125), info: "the city of....")
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "where is my tea!")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "let's get married!")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "so old")
        let wasingtone = Capital(title: "Washingtone", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "50 cent")
        
        mapView.addAnnotations([dhaka, london, oslo, paris, rome, wasingtone])
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Map type", style: .plain, target: self, action: #selector(chooseMap))
        
        
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else {return nil}
        
        let identifier = "Capital"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        if annotationView == nil{
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        }else{
            annotationView?.annotation = annotation
        }
        
        annotationView?.pinTintColor = .black
        return annotationView
    }

//    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
//        guard let capital = view.annotation as? Capital else {return}
//        let placeName = capital.title
//        let placeInfo = capital.info
//
//        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
//        ac.addAction(UIAlertAction(title: "ok", style: .default))
//        present(ac, animated: true)
//    }

    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else {return}

        let placeName = capital.title
        let placeInfo = capital.info
        let wikipediaURL = "https://en.wikipedia.org/wiki/\(placeName!.replacingOccurrences(of: " ", with: "_"))"

        let webViewVC = WebViewController()
        webViewVC.urlString = wikipediaURL
        webViewVC.title = placeName
        navigationController?.pushViewController(webViewVC, animated: true)
    }

    
    @objc func chooseMap(){
        let mapAc = UIAlertController(title: "Map Type", message: "choose your map type", preferredStyle: .actionSheet)
        mapAc.addAction(UIAlertAction(title: "Standard", style: .default, handler:{
            [weak self] _ in
            self?.mapView.mapType = .standard
        }))
        mapAc.addAction(UIAlertAction(title: "Hybrid", style: .default, handler:{
            [weak self] _ in
            self?.mapView.mapType = .hybrid
        }))
        mapAc.addAction(UIAlertAction(title: "Satellite", style: .default, handler:{
            [weak self] _ in
            self?.mapView.mapType = .satellite
        }))
        mapAc.addAction(UIAlertAction(title: "CANCLE", style: .cancel))
        present(mapAc, animated: true)
    }
    
}


