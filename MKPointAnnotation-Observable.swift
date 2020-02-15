//
//  MKPointAnnotation-Observable.swift
//  MapViewDemo
//
//  Created by MC on 2020/2/15.
//  Copyright © 2020 MC. All rights reserved.
//

import MapKit

extension MKPointAnnotation: ObservableObject {
    public var wrappedTitle: String {
        get {
            title ?? ""
        }
        set {
            title = newValue
        }
    }
    
    public var wrappedSubtitle: String {
        get {
            subtitle ?? ""
        }
        set {
            subtitle = newValue
        }
    }
}
