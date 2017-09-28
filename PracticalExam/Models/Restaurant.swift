//
//  Restaurant.swift
//  PracticalExam
//
//  Created by mobile.dev on 9/25/17.
//  Copyright © 2017 praticalexam.com. All rights reserved.
//

import Foundation
import UIKit

class Restaurant: NSObject{
    var id = String()
    var name = String()
    var vicinity = String()
    var lat = Double()
    var lng = Double()
    var photos = Photo()
    var image = UIImage()
    var distance = Double()
    
    var restaurantImg = UIImage()
    
    override init() {
        self.id = String()
        self.name = String()
        self.vicinity = String()
        self.lat = Double()
        self.lng = Double()
        self.photos = Photo()
        self.image = UIImage()
        self.distance = Double()
        self.restaurantImg = UIImage()
    }
    
    init(id: String, name: String, vicinity: String, lat: Double, lng: Double, photos: Photo, image: UIImage, distance: Double, restaurantImg: UIImage){
        self.id = id
        self.name = name
        self.vicinity = vicinity
        self.lat = lat
        self.lng = lng
        self.photos = photos
        self.image = image
        self.distance = distance
        self.restaurantImg = restaurantImg
    }
}
