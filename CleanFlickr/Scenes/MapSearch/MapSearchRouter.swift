//
//  MapSearchRouter.swift
//  CleanFlickr
//
//  Created by Iñigo on 24/08/2018.
//  Copyright (c) 2018 Iñigo. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol MapSearchRoutingLogic
{
  func routeToPhotoDetail(segue: UIStoryboardSegue?)
}

protocol MapSearchDataPassing
{
  var dataStore: MapSearchDataStore? { get }
}

class MapSearchRouter: NSObject, MapSearchRoutingLogic, MapSearchDataPassing
{
    weak var viewController: MapSearchViewController?
    var dataStore: MapSearchDataStore?
    
    func routeToPhotoDetail(segue: UIStoryboardSegue?) {
        
        if let segue = segue {
            let destinationVC = segue.destination as! PhotoDetailViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToPhotoDetail(source: dataStore!, destination: &destinationDS)
        } else {
            let destinationVC = viewController?.storyboard?.instantiateViewController(withIdentifier: "PhotoDetailViewController") as! PhotoDetailViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToPhotoDetail(source: dataStore!, destination: &destinationDS)
            navigateToPhotoDetail(source: viewController!, destination: destinationVC)
        }
    }
    
      // MARK: - Passing data
    
    func passDataToPhotoDetail(source: MapSearchDataStore, destination: inout PhotoDetailDataStore)
    {
        for p in source.photos!
        {
            if p.url_m == viewController?.selectedPhoto?.bigImageUrl
            {
                destination.photo = p
                break
            }
        }
    }
    
    // MARK: - Navigation
    func navigateToPhotoDetail(source: MapSearchViewController, destination: PhotoDetailViewController)
    {
        source.show(destination, sender: nil)
    }
}
