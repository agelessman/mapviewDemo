//
//  CodableMKPointAnnotation-Codable.swift
//  MapViewDemo
//
//  Created by MC on 2020/2/15.
//  Copyright © 2020 MC. All rights reserved.
//

import MapKit

class CodableMKPointAnnotation: MKPointAnnotation, Codable {
    override init() {
        super.init()
    }
    
    enum CodingKeys: CodingKey {
        case title, subtitle, latitude, longitude
    }
    
    
    
    public required init(from decoder: Decoder) throws {
        super.init()
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        title = try container.decode(String.self, forKey: .title)
        subtitle = try container.decode(String.self, forKey: .subtitle)
        
        let latitude = try container.decode(CLLocationDegrees.self, forKey: .latitude)
        let longitude = try container.decode(CLLocationDegrees.self, forKey: .longitude)
        
        coordinate = CLLocationCoordinate2DMake(latitude, longitude)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(title, forKey: .title)
        try container.encode(subtitle, forKey: .subtitle)
        try container.encode(coordinate.latitude, forKey: .latitude)
        try container.encode(coordinate.longitude, forKey: .longitude)
    }
}
