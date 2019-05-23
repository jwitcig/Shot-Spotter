//
//  Location.swift
//  ShotSpotter
//
//  Created by Jonah Witcig on 5/22/19.
//  Copyright © 2019 University of Missouri. All rights reserved.
//

import Foundation

struct Location: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
    }
    
    let latitude: Double
    let longitude: Double
}
