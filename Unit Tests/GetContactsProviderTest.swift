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

class GetContactsProviderTest: XCTestCase {
        
    func testGetContactWithValidResponse() {
        let api = ContactApiMock()
        let contacts = GetContactsProviderImpl(service: api).get()
        
        XCTAssertNotNil(contacts
        )
        let result = contacts.firstEmit()
        XCTAssertEqual(result!.count, 3)
        XCTAssertEqual(result!.first?.id, 18145)
        XCTAssertEqual(result!.first?.fistname, "robzimpulse")
        XCTAssertEqual(result!.first?.lastname, "awesome")
        
        XCTAssertEqual(result!.last?.id, 17313)
        XCTAssertEqual(result!.last?.fistname, "S Singh")
        XCTAssertEqual(result!.last?.lastname, "S Singh")
    }

}
