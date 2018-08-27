//
//  Seeds.swift
//  CleanFlickrTests
//
//  Created by Iñigo on 27/08/2018.
//  Copyright © 2018 Iñigo. All rights reserved.
//

@testable import CleanFlickr
import XCTest
import MapKit

struct Seeds
{
    static let searchText = "Indigo"
    static let bbox = "&bbox=3.50513144343881%2C50.2222535478254%2C6.97582055656125%2C54.0518104521745"
    
    struct Photos
    {
        static let photo1 = Photo(title: "Indigo-ish", url_t: URL(string: "https://farm1.staticflickr.com/929/29999182258_8e0b82d23c_t.jpg")!, latitude: 52.394952000000004, longitude: 5.013458, url_m: URL(string: "https://farm1.staticflickr.com/929/29999182258_8e0b82d23c.jpg")!, coordinate: CLLocationCoordinate2D(latitude: 52.394952000000004, longitude: 5.013458), image: UIImage())
        static let photo2 = Photo(title: "Hotel Indigo", url_t: URL(string: "https://farm1.staticflickr.com/841/42679984445_478d224827_t.jpg")!, latitude: 52.080832000000001, longitude: 4.3075739999999998, url_m: URL(string: "https://farm1.staticflickr.com/841/42679984445_478d224827.jpg")!, coordinate: CLLocationCoordinate2D(latitude: 52.080832000000001, longitude: 4.3075739999999998), image: UIImage())
        static let photo3 = Photo(title: "Dye bath 1", url_t: URL(string: "https://farm1.staticflickr.com/853/42060230370_77ac0d683b_t.jpg")!, latitude: 52.394941000000003, longitude: 5.0137, url_m: URL.init(string: "https://farm1.staticflickr.com/853/42060230370_77ac0d683b.jpg")!, coordinate: CLLocationCoordinate2D.init(latitude: 52.394941000000003, longitude: 5.0137), image: UIImage())
    }
}
