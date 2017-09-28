//
//  Photo.swift
//  PracticalExam
//
//  Created by mobile.dev on 9/25/17.
//  Copyright © 2017 praticalexam.com. All rights reserved.
//

import Foundation

class Photo: NSObject{
    var height = Int()
    var html_attributions = [String]()
    var photo_reference = String()
    var width = Int()
    
    override init() {
        self.height = Int()
        self.html_attributions = [String]()
        self.photo_reference = String()
        self.width = Int()
    }
    
    init(height: Int, html_attributions:[String], photo_reference:String, width:Int){
        self.height = height
        self.html_attributions = html_attributions
        self.photo_reference = photo_reference
        self.width = width
    }
}
