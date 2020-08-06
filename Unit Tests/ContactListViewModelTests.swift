//
//  ContactListViewModelTests.swift
//  contacts-APPTests
//
//  Created by Yonathan Wijaya on 06/08/20.
//  Copyright © 2020 Yonathan Wijaya. All rights reserved.
//

import XCTest
import RxSwift
@testable import contacts_APP

class ContactListViewModelTests: XCTestCase {
    private var viewModel: ContactListViewModel!
    private var providerMock : ContactListProviderMock!
    
    override func setUp() {
        super.setUp()
        providerMock = ContactListProviderMock()
        viewModel = ContactListViewModel(provider: providerMock)
    }
    
    func testViewDidLoad() {
        let expect = expectation(description: "expect load default product")
        
        let disposable = viewModel.contact
            .subscribe(onNext: { _ in
                expect.fulfill()
            })
        
        defer { disposable.dispose() }
        
        viewModel.viewLoad()
        waitForExpectations(timeout: 0.5, handler: nil)
    }
    
    func testGetContactsItemCount() {
        viewModel.viewLoad()
        XCTAssertEqual(viewModel.getContactount(), 3)

    }
    
    func testContactAtIndex() {
        let expectedContact = ContactsListResponse(id: 16267,
                                                    fistname: "Sanjay",
                                                    lastname: "Kumar",
                                                    favorite: true,
                                                    profilepic: "/images/missing.png",
                                                    url: "http://gojek-contacts-app.herokuapp.com/contacts/16267.json")
        
        
        viewModel.viewLoad()
        XCTAssertEqual(expectedContact, viewModel.itemAt(index: 1))
        
    }
    
    func testDidSelectContactAt() {
        let expectedContact = ContactsListResponse(id: 18145,
                                                    fistname: "robzimpulse",
                                                    lastname: "awesome",
                                                    favorite: true,
                                                    profilepic: "/images/missing.png",
                                                    url: "http://gojek-contacts-app.herokuapp.com/contacts/18145.json")
        
        
        viewModel.viewLoad()
        XCTAssertEqual(expectedContact, viewModel.didSelectContact(at: 0))
    }
}

class ContactListProviderMock: ContactListProvider {
    var contacts = ContactApiMock().sample
    private var contactList: [ContactsListResponse] = []

    func get() -> Observable<[ContactsListResponse]> {
        return .just(decodeToResponse(from: contacts)!)
    }

    private func decodeToResponse(from jsonString: String) -> [ContactsListResponse]? {
        do {
            let data = Data(contacts.utf8)

            let decoder = JSONDecoder()
            return try decoder.decode([ContactsListResponse].self, from: data)
        } catch {
            return nil
        }
    }

    func emit(contacts: [ContactsListResponse]) {
        self.contactList = contacts
    }
}

