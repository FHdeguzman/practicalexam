//
//  JsonParser.swift
//  PracticalExam
//
//  Created by mobile.dev on 9/25/17.
//  Copyright © 2017 praticalexam.com. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import AlamofireImage
import SDWebImage

 func request(_ method: Alamofire.HTTPMethod, url: String, completionHandler:@escaping (_ image:UIImage?, _ success:Bool?) -> Void) {

    Alamofire.request(url).responseImage { response in
        debugPrint(response)
        if let image = response.result.value {
             completionHandler(image, nil)
        }else{
            
            completionHandler(#imageLiteral(resourceName: "restaurant-photo-default"), nil)
        }
    }

}

func parseRestaurantListFromArray(object: NSArray) -> [Restaurant]{
    var restaurantList = [Restaurant]()
    let json = JSON(object)
    
    
    for i in 0..<json.count{
        let restaurant = Restaurant()
        if let id = json[i]["id"].string{
            restaurant.id = id
        }
        
        if let name = json[i]["name"].string{
            restaurant.name = name
        }
        
        if let vicinity = json[i]["vicinity"].string{
            restaurant.vicinity = vicinity
        }
        
        if let lat = json[i]["geometry"]["location"]["lat"].double{
            restaurant.lat = lat
        }
        
        if let lng = json[i]["geometry"]["location"]["lng"].double{
            restaurant.lng = lng
        }
        
        if let height = json[i]["photos"][0]["height"].int{
            restaurant.photos.height = height
        }
        
        if let htmlAttributions = json[i]["photos"][0]["html_attributions"].arrayObject{
            restaurant.photos.html_attributions = htmlAttributions as! [String]
        }
        
        if let photoReference = json[i]["photos"][0]["photo_reference"].string{
            restaurant.photos.photo_reference = photoReference
        }
        
        if let width = json[i]["photos"][0]["width"].int{
            restaurant.photos.width = width
        }
        
        restaurantList.append(restaurant)
 
    }
    

    
    return restaurantList
}



