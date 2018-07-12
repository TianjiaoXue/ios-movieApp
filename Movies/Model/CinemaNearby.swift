//
//  Cinema.swift
//  Movies
//
//  Created by Tianjiao Xue on 4/24/18.
//  Copyright © 2018 Tianjiao Xue. All rights reserved.
//

import Foundation
import SwiftyJSON

struct CinemaNearby {
    let lat: Double
    let lng: Double
    
    
   
    init(lat:Double,lng:Double) {
        
        self.lat = lat
        self.lng = lng
    
    }
}
