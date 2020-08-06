//
//  ProductApiTest.swift
//  contacts-APPTests
//
//  Created by Yonathan Wijaya on 06/08/20.
//  Copyright © 2020 Yonathan Wijaya. All rights reserved.
//

import XCTest
@testable import contacts_APP
class ProductApiTest: XCTestCase {

    func testURLPath() {
        let urlPath = ContactsApi()
        
        let expectedUrl = "http://gojek-contacts-app.herokuapp.com/contacts.json"
        
        XCTAssertEqual(expectedUrl, urlPath.path)
    }

}
