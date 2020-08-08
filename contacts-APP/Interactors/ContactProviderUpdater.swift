//
//  ContactProviderUpdater.swift
//  contacts-APP
//
//  Created by Yonathan Wijaya on 08/08/20.
//  Copyright © 2020 Yonathan Wijaya. All rights reserved.
//

import Foundation
import RxSwift

protocol ContactProviderUpdater {
    func updateContact(id: Int, params: [String: Any]) -> Observable<ContactUpdaterResponse>
}

struct ContactProviderUpdaterImpl: ContactProviderUpdater {
    private let service: UpdateContact
    
    init(service: UpdateContact) {
        self.service = service
    }
    
    func updateContact(id: Int, params: [String: Any]) -> Observable<ContactUpdaterResponse> {
        let requester = ContactUpdaterRequester(requestContacts: service.getContactId(id: id, params: params))
        return requester.request().asObservable()
    }
}

struct ContactProviderUpdaterFactory {
    static func create() -> ContactProviderUpdater {
        return ContactProviderUpdaterImpl(service: UpdateContactImpl())
    }
}
