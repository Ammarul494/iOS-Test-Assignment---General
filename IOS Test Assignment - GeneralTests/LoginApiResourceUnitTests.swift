//
//  LoginApiResourceUnitTests.swift
//  IOS Test Assignment - GeneralTests
//
//  Created by Ammar Ul Haq on 16/05/2022.
//

import XCTest
@testable import IOS_Test_Assignment___General

class LoginApiResourceUnitTests: XCTestCase {
    
    
    //Search api test case added. Test case will fail in 2 cases:
    // 1) Error message != success
    // 2) List count == 0
    
    func test_LoginApiResourceValidRequest()
    {
        let searchKeyword = "foo"
        
        let expectation = self.expectation(description: "ResourceValidRequest")
        
        DataLayer.sharedInstance.getSearchResults(search: searchKeyword) { list, success, errorDesc in
        
            XCTAssertEqual(errorDesc, "success")
            XCTAssertNotEqual(list.count, 0, "Empty list")
            expectation.fulfill()
        }
        
        
        waitForExpectations(timeout: 5, handler: nil)
    }

   

}
