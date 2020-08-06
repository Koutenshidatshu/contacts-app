//
//  GetContactsTests.swift
//  contacts-APPTests
//
//  Created by Yonathan Wijaya on 06/08/20.
//  Copyright © 2020 Yonathan Wijaya. All rights reserved.
//

import XCTest
import RxSwift
@testable import contacts_APP

class GetContactsTests: XCTestCase {
    func testGetDatas() {
        let jsonString = createRequestString()
        let hasID = jsonString.contains("id")
        XCTAssertTrue(hasID)
        
        let hasFirstName = jsonString.contains("first_name")
        XCTAssertTrue(hasFirstName)

        let hasLastName = jsonString.contains("last_name")
        XCTAssertTrue(hasLastName)
        
        let hasProfilePic = jsonString.contains("profile_pic")
        XCTAssertTrue(hasProfilePic)
        
        let hasFavorite = jsonString.contains("favorite")
        XCTAssertTrue(hasFavorite)
        
        let hasUrl = jsonString.contains("url")
        XCTAssertTrue(hasUrl)
        
        
    }
    
    private func createRequestString() -> String {
        let data = GetContactsImpl().get().firstEmit()!
        return String(data: data, encoding: .utf8)!
    }
}
