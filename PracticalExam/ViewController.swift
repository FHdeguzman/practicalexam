//
//  ViewController.swift
//  PracticalExam
//
//  Created by mobile.dev on 9/22/17.
//  Copyright © 2017 praticalexam.com. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import AlamofireImage
import SwiftyJSON
import GooglePlaces
import SDWebImage


class ViewController: UIViewController, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, UISearchResultsUpdating {
    
    let locationManager = CLLocationManager()
    var currentLocation = CLLocation()
    var newLocation = CLLocation()
    var nearbyRestaurantList = [Restaurant]()
    var hasSentLocation = Bool()
    var restaurantSelected = Restaurant()
    var filteredRestaurants = [Restaurant]()
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet var restaurantListTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restaurantListTableView.dataSource = self
        restaurantListTableView.delegate = self
        
        self.navigationController?.isNavigationBarHidden = true
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        restaurantListTableView.tableHeaderView = searchController.searchBar
        
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        
        //check if gps is on
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        
    }
    
    func refreshData(){
        filteredRestaurants = nearbyRestaurantList
        restaurantListTableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        // If we haven't typed anything into the search bar then do not filter the results
        if searchController.searchBar.text! == "" {
            filteredRestaurants = nearbyRestaurantList
        } else {
            // Filter the results
            filteredRestaurants = nearbyRestaurantList.filter { $0.name.lowercased().contains(searchController.searchBar.text!.lowercased()) }
        }
        
        self.restaurantListTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        if (!hasSentLocation){
            retrieveNearbyRestaurants(longitude: locValue.longitude, latitude: locValue.latitude)
            hasSentLocation = true
            self.currentLocation = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
        }
        
        self.newLocation = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
        let distanceInMeters = self.currentLocation.distance(from: self.newLocation)
        
        if(distanceInMeters < 100){
            print("No significant change in location")
        }else{
            retrieveNearbyRestaurants(longitude: locValue.longitude, latitude: locValue.latitude)
            //set current location to the coordinate where the significant change in location happened
            self.currentLocation = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
        }
    }
    
    func retrieveNearbyRestaurants(longitude: Double, latitude: Double) {
        Alamofire.request("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(latitude),\(longitude)&rankby=distance&type=restaurant&key=\(Properties.PLACE_API_KEY)", method: .get) .responseJSON{
            response in
            
            if let result = response.result.value{
                let json = JSON(result)
                let restaurantList = json["results"].arrayObject
                self.nearbyRestaurantList = parseRestaurantListFromArray(object: restaurantList! as NSArray)
                self.refreshData()
            }
            
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredRestaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "restaurant", for: indexPath) as! RestaurantTableViewCell
        cell.selectionStyle = .none
        cell.name.text = filteredRestaurants[indexPath.row].name
        cell.address.text = filteredRestaurants[indexPath.row].vicinity
        let restaurantLocation = CLLocation(latitude: filteredRestaurants[indexPath.row].lat, longitude: filteredRestaurants[indexPath.row].lng)
        let distanceInMeters = Double(self.currentLocation.distance(from: restaurantLocation))
        cell.distance.text = "\(distanceInMeters.rounded(toPlaces: 2)) meters away"
        filteredRestaurants[indexPath.row].distance = distanceInMeters
        
        cell.photo.image = filteredRestaurants[indexPath.row].restaurantImg
        
        let url = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=100&photoreference=\(filteredRestaurants[indexPath.row].photos.photo_reference)&key=\(Properties.PLACE_API_KEY)"
        
        
        
        cell.photo.sd_setShowActivityIndicatorView(true)
        cell.photo.sd_setIndicatorStyle(.gray)
        
        
        cell.photo.sd_setImage(with: URL(string: url), placeholderImage: #imageLiteral(resourceName: "restaurant-photo-default"))
        
//        Alamofire.request(url).responseImage { response in
//            debugPrint(response)
//            if let image = response.result.value {
//                cell.photo.image = image
//            }else{
//                cell.photo.image = #imageLiteral(resourceName: "restaurant-photo-default")
//            }
//        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        restaurantSelected = filteredRestaurants[indexPath.row]
        self.performSegue(withIdentifier: "showDetails", sender: self)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showDetails"){
            let vc = segue.destination as! RestaurantDetailsViewController
            vc.restaurantSelected = restaurantSelected
            
        }
        
        
    }
    
}





