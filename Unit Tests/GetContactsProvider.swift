//
//  GetContactsProvider.swift
//  contacts-APPTests
//
//  Created by Yonathan Wijaya on 06/08/20.
//  Copyright © 2020 Yonathan Wijaya. All rights reserved.
//

import XCTest
import RxSwift
@testable import contacts_APP

class GetContactsProviderTests: XCTestCase {
    class ProductApiMock: GetContacts {
        
    let sample = {
        """
        {
            "id": 18145,
            "first_name": "robzimpulse",
            "last_name": "awesome",
            "profile_pic": "/images/missing.png",
            "favorite": true,
            "url": "http://gojek-contacts-app.herokuapp.com/contacts/18145.json"
        },
        {
            "id": 16267,
            "first_name": "Sanjay",
            "last_name": "Kumar",
            "profile_pic": "/images/missing.png",
            "favorite": true,
            "url": "http://gojek-contacts-app.herokuapp.com/contacts/16267.json"
        },
        {
            "id": 17313,
            "first_name": "S Singh",
            "last_name": "S Singh",
            "profile_pic": "/images/missing.png",
            "favorite": true,
            "url": "http://gojek-contacts-app.herokuapp.com/contacts/17313.json"
        }
        """
        }
        
        
    func testGetContactWithValidResponse() {
        let api = ProductApiMock()
        let contacts = GetContactsProviderTests(service: api).get()
        
        XCTAssertNotNil(contacts
        )
        let result = contacts.firstEmit()
        XCTAssertEqual(result!.count, 3)
        XCTAssertEqual(result!.id, 1845)
    }

}
