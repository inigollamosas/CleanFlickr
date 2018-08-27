//
//  PhotosAPI.swift
//  CleanFlickr
//
//  Created by Iñigo on 24/08/2018.
//  Copyright © 2018 Iñigo. All rights reserved.
//

import Foundation
import MapKit
import UIKit

class PhotosAPI: PhotosStoreProtocol
{
    static var photos: [Photo] = []
    
    func fetchPhotos (searchText: String, bbox: String, completionHandler: @escaping (() throws -> [Photo]) -> Void)
    {
        if searchText == ""{
            return
        }
        let safeSearchText = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let baseUrl = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=350c476c1671f9bf0ffe5e1751f8c5e9&has_geo=1&extras=url_t%2Curl_m%2Cgeo&format=json&per_page=3&nojsoncallback=1&text=" + safeSearchText! + bbox
        let url = URL(string: baseUrl)
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            DispatchQueue.main.async(execute: { () -> Void in
                if let _ = error{
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "noConnection"), object: nil, userInfo: nil)
                }else{
                    guard let dataValue = data else {
                        return
                    }
                    do {
                        let root = try JSONDecoder().decode(Root.self, from: dataValue)
                        for p in root.photos.photo
                        {
                            let p = Photo(title: p.title, url_t: p.url_t, latitude: p.latitude, longitude: p.longitude, url_m: p.url_m, coordinate: p.coordinate, image: p.image)
                            PhotosAPI.photos.append(p)
                        }
                        completionHandler { return type(of: self).photos }
                    } catch {
                        print(error)
                    }
                }
            })
        })
        task.resume()
    }
}


struct Root : Decodable {
    let photos: Photos
}

struct Photos : Decodable {
    let photo : [PhotoDecodable]
}

struct PhotoDecodable : Decodable {
    
    let title: String
    let url_t: URL
    let latitude: Double
    let longitude: Double
    let url_m: URL
    let coordinate: CLLocationCoordinate2D
    var image = UIImage()
    
    enum CodingKeys: String, CodingKey {
        case title, url_t, latitude, longitude, url_m
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decode(String.self, forKey: CodingKeys.title)
        url_t = try values.decode(URL.self, forKey: CodingKeys.url_t)
        
        guard let tempLatitude = try Double(values.decode(String.self, forKey: .latitude)) else {
            throw DecodingError.dataCorrupted(.init(codingPath: [CodingKeys.latitude], debugDescription: "Expecting string representation of Float"))
        }
        latitude = tempLatitude
        
        guard let tempLongitude = try Double(values.decode(String.self, forKey: .longitude)) else {
            throw DecodingError.dataCorrupted(.init(codingPath: [CodingKeys.latitude], debugDescription: "Expecting string representation of Float"))
        }
        longitude = tempLongitude
        
        url_m = try values.decode(URL.self, forKey: CodingKeys.url_m)
        coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        if let d = NSData(contentsOf: (url_t)){
            image = UIImage(data: d as Data)!
        }
    }
}
