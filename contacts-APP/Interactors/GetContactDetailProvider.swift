//
//  GetContactDetailProvider.swift
//  contacts-APP
//
//  Created by Yonathan Wijaya on 07/08/20.
//  Copyright © 2020 Yonathan Wijaya. All rights reserved.
//

import Foundation
import RxSwift


protocol GetContactDetailProvider {
    func getContactDetail(id: Int) -> Observable<ContactDetailResponse>
}

struct GetContactDetailProviderImpl: GetContactDetailProvider {
    private let service: GetContactDetail
    
    init(service: GetContactDetail) {
        self.service = service
    }
    
    func getContactDetail(id: Int) -> Observable<ContactDetailResponse> {
        let requester = ContactDetailRequester(requestContacts: service.getContactId(id: id))
        return requester.request().asObservable()
    }
}

struct GetContactDetailProviderFactory {
    static func create() -> GetContactDetailProvider {
        return GetContactDetailProviderImpl(service: GetContactDetailImpl())
    }
}
