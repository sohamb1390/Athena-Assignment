//
//  Athena_AssigmentTests.swift
//  Athena-AssigmentTests
//
//  Created by Soham Bhattacharjee on 16/12/19.
//  Copyright © 2019 Soham Bhattacharjee. All rights reserved.
//

import XCTest
@testable import Athena_Assigment
@testable import Zip

class Athena_AssigmentTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        continueAfterFailure = false
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    // MARK: - Test Zip File download
    func testZipFileDownload() {
        let networkAdapter = AthenaNetworkAdapter.shared
        let expectation = XCTestExpectation(description: "Athena Download files API Test")
        networkAdapter.downloadRequestAPI(with: AthenaAPI.downloadFiles) { (result) in
            switch result {
            case .success(let url):
                XCTAssertNotNil(url, "Download Location URL not found")
                print(url!)
                expectation.fulfill()
                self.fileSave(from: url!)
            case .failure(let error):
                XCTAssertNil(error, "API responded with error")
            }
        }
        wait(for: [expectation], timeout: 15.0)
    }
    
    func fileSave(from location: URL) {
        let documentsUrl = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        // your destination file url
        let destination = documentsUrl.appendingPathComponent("Athena-Assignment.zip")
        print(destination)
        
        if FileManager.default.fileExists(atPath: destination.path) {
            print("File Exists at \(destination.path.appending("/Athena-Assignment"))")
        } else {
            do {
                try FileManager.default.moveItem(at: location, to: destination)
                print("file saved at: \(destination)")
                unzipFile(at: destination)
            } catch {
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Unzip Test
    func unzipFile(at url: URL){
        do {
            let unzipDirectory = try Zip.quickUnzipFile(url) // Unzip
            XCTAssert(!unzipDirectory.path.isEmpty, "Directory not found")
            print("---- file unzipped at: ------- \(unzipDirectory.path)")

            let zipFilePath = try Zip.quickZipFiles([url], fileName: "Athena-Assignment") // Zip
            XCTAssert(!zipFilePath.absoluteString.isEmpty, "zipFilePath not found")
        } catch (let error) {
            XCTFail(error.localizedDescription)
        }
    }
}
