//
//  Photo.swift
//  CleanFlickr
//
//  Created by Iñigo on 24/08/2018.
//  Copyright © 2018 Iñigo. All rights reserved.
//

import UIKit
import Foundation
import MapKit

struct Photo: Equatable
{
    var title: String
    var url_t: URL
    var latitude: Double
    var longitude: Double
    var url_m: URL
    var coordinate: CLLocationCoordinate2D
    var image = UIImage()
}

func ==(lhs: Photo, rhs: Photo) -> Bool
{
    return lhs.title == rhs.title
        && lhs.url_t == rhs.url_t
        && lhs.latitude == rhs.latitude
        && lhs.longitude == rhs.longitude
        && lhs.url_m == rhs.url_m
//        && lhs.coordinate == rhs.coordinate
//        && lhs.image == rhs.image
}
