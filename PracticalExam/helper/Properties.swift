//
//  Properties.swift
//  PracticalExam
//
//  Created by mobile.dev on 9/26/17.
//  Copyright © 2017 praticalexam.com. All rights reserved.
//

import Foundation
import UIKit


class Properties{
    static var PLACE_API_KEY = "AIzaSyCPIx1zxgf4Jaz0uyqA15bhLbLRZOrFg5s"
    static var GOOGLE_MAP_API_KEY = "AIzaSyC6EdLutlhr5dW_9dG2CwmxgJ-U_I0MRRE"
}

extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
