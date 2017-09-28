//
//  RestaurantDetailsViewController.swift
//  PracticalExam
//
//  Created by mobile.dev on 9/25/17.
//  Copyright © 2017 praticalexam.com. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation
import Alamofire
import AlamofireImage
import SDWebImage

class RestaurantDetailsViewController: UIViewController, UISearchBarDelegate, CLLocationManagerDelegate {
    
    @IBOutlet var image: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var address: UILabel!
    @IBOutlet var distance: UILabel!
    @IBOutlet var map: GMSMapView!

    var restaurantSelected = Restaurant()
    var googleMapsView:GMSMapView!
    var locationManager = CLLocationManager()
    var geocoder = CLGeocoder()
    
    let marker = GMSMarker()
    
    var polyline = GMSPolyline()
    var animationPolyline = GMSPolyline()
    var path = GMSPath()
    var animationPath = GMSMutablePath()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false

        //image.image = restaurantSelected.image
        
        
        let url = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=1000&photoreference=\(restaurantSelected.photos.photo_reference)&key=\(Properties.PLACE_API_KEY)"
        
        image.sd_setShowActivityIndicatorView(true)
        image.sd_setIndicatorStyle(.gray)
        
        
        image.sd_setImage(with: URL(string: url), placeholderImage: #imageLiteral(resourceName: "no-image-available"))
        
        name.text = restaurantSelected.name
        address.text = restaurantSelected.vicinity
        
        distance.text = "\(Double(restaurantSelected.distance).rounded(toPlaces: 2)) meters away"
        

        self.map.settings.compassButton = true
        self.map.isMyLocationEnabled = true
        self.map.settings.myLocationButton = true
    
        
        marker.position = CLLocationCoordinate2D(latitude: CLLocationDegrees(restaurantSelected.lat), longitude: CLLocationDegrees(restaurantSelected.lng))
        marker.title = restaurantSelected.name
        marker.map = map
        
        let cameraPosition = GMSCameraPosition.camera(withLatitude: restaurantSelected.lat, longitude: restaurantSelected.lng, zoom: 16.0)
        map?.animate(to: cameraPosition)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
