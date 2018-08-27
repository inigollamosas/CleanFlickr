//
//  PhotosAPITests.swift
//  CleanFlickrTests
//
//  Created by Iñigo on 27/08/2018.
//  Copyright © 2018 Iñigo. All rights reserved.
//

@testable import CleanFlickr
import XCTest
import Foundation

class PhotosAPITests: XCTestCase
{
    // MARK: - Subject under test
    
    var sut: PhotosAPI!
    var testPhotos: [Photo]!
    
    // MARK: - Test lifecycle
    
    override func setUp()
    {
        super.setUp()
        setupPhotosAPI()
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupPhotosAPI()
    {
        sut = PhotosAPI()
        
        testPhotos = [Seeds.Photos.photo1, Seeds.Photos.photo2, Seeds.Photos.photo3]
    }
    
    // MARK: - Test CRUD operations - Inner closure
    func testFetchPhotosShouldReturnListOfPhotos_InnerClosure()
    {
        // Given
        
        // When
        var fetchedPhotos = [Photo]()
        var fetchPhotosError: PhotosStoreError?
        let expect = expectation(description: "Wait for fetchPhotos() to return")
        
        sut.fetchPhotos(searchText: Seeds.searchText, bbox: Seeds.bbox, completionHandler: { (photos: () throws -> [Photo]) -> Void in
            do {
                fetchedPhotos = try photos()
            } catch let error as PhotosStoreError {
                fetchPhotosError = error
            } catch {}
            expect.fulfill()
        })
        waitForExpectations(timeout: 3.0)
        
        // Then
        XCTAssertEqual(fetchedPhotos.count, testPhotos.count, "fetchedPhotos() should return a list of photos")
        for photo in fetchedPhotos {
            XCTAssert(testPhotos.contains(photo), "Fetched photos should match the photos in the API call")
        }
        XCTAssertNil(fetchPhotosError, "fetchPhotos() should not return an error")
    }
}
