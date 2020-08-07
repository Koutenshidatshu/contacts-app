//
//  GetContactsProvider.swift
//  contacts-APP
//
//  Created by Yonathan Wijaya on 06/08/20.
//  Copyright © 2020 Yonathan Wijaya. All rights reserved.
//

import Foundation
import RxSwift
protocol ContactListProvider {
    func get() -> Observable<[ContactsListResponse]>
}

struct GetContactsProviderImpl: ContactListProvider {
    private let service: GetContacts
    
    init(service: GetContacts) {
        self.service = service
    }
    
    func get() -> Observable<[ContactsListResponse]> {
        let requester = ContactListRequester(requestContacts: service.get())
        return requester.request().asObservable()
    }
}

struct ContactListProviderFactory {
    static func create() -> ContactListProvider {
        return GetContactsProviderImpl(service: GetContactsImpl())
    }
}
