//
//  ContactResponseTest.swift
//  contacts-APPTests
//
//  Created by Yonathan Wijaya on 06/08/20.
//  Copyright © 2020 Yonathan Wijaya. All rights reserved.
//

import XCTest
import RxSwift

@testable import contacts_APP

class ContactResponseTest: XCTestCase {

    
    private let emptyData = {
           return """
               []
           """
       }()
       
       private let validData = {
           """
           [
               {
                   "id": 18049,
                   "first_name": "a2",
                   "last_name": "a2",
                   "profile_pic": "/images/missing.png",
                   "favorite": true,
                   "url": "http://gojek-contacts-app.herokuapp.com/contacts/18049.json"
               },
               {
                   "id": 17947,
                   "first_name": "AAA",
                   "last_name": "Rath",
                   "profile_pic": "/images/missing.png",
                   "favorite": true,
                   "url": "http://gojek-contacts-app.herokuapp.com/contacts/17947.json"
               }
           ]
           """
       }()
       
       private let invalidData = {
           """
           {}
           """
       }()
    
    func testParseContactWithEmptyData() {
        let disposeBag = DisposeBag()
        let contactListResponse = ContactListRequester(requestContacts: .just(emptyData.data(using: .utf8)!))
        var result: ContactsListResponse?
        
        contactListResponse.request()
            .subscribe(onSuccess: { result = $0.first })
            .disposed(by: disposeBag)
        
        XCTAssertNil(result)
    }

    func testParseContactWithValidData() {
        let disposeBag = DisposeBag()
        let contactListResponse = ContactListRequester(requestContacts:
            .just(validData.data(using: .utf8)!))
        var result: ContactsListResponse?

        contactListResponse.request()
            .subscribe(onSuccess: { result = $0.first },
                       onError: { XCTFail("fail with error \($0.localizedDescription)") })
            .disposed(by: disposeBag)

        XCTAssertNotNil(result)
        XCTAssertEqual(result?.id, 18049)
        XCTAssertEqual(result?.fistname, "a2")
        XCTAssertEqual(result?.lastname, "a2")
        XCTAssertEqual(result?.favorite, true)
        XCTAssertEqual(result?.profilepic, "/images/missing.png")
        XCTAssertEqual(result?.url, "http://gojek-contacts-app.herokuapp.com/contacts/18049.json")
    }

    func testWithInvalidData() {
        let disposeBag = DisposeBag()
        let contactListResponse = ContactListRequester(requestContacts:
            .just(invalidData.data(using: .utf8)!))
        var capturedError : ContactListRequester.RequestError?

        contactListResponse.request()
            .subscribe(onError: { capturedError = ($0 as? ContactListRequester.RequestError) })
            .disposed(by: disposeBag)
        XCTAssertEqual(capturedError, .parseFailure)
    }
}
