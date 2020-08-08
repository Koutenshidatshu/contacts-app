//
//  ContactListViewModel.swift
//  contacts-APP
//
//  Created by Yonathan Wijaya on 06/08/20.
//  Copyright © 2020 Yonathan Wijaya. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ContactListViewModel {
    lazy var contact: Observable<[ContactsListResponse]> = contactRelay.asObservable()
    
    private let provider : ContactListProvider
    private let disposeBag = DisposeBag()
    private let contactRelay = PublishRelay<[ContactsListResponse]>()
    private var contacts = [ContactsListResponse]()
    
    init(provider: ContactListProvider) {
        self.provider = provider
    }
    
    func viewLoad() {
        provider.get()
            .subscribe(onNext: { [weak self] result in
                self?.contacts.removeAll()
                self?.contacts.append(contentsOf: result)
                self?.contactRelay.accept(result)
        }).disposed(by: disposeBag)
    }
    
    func getContactount() -> Int {
        print("@@@@  count", contacts.count)
        return contacts.count
    }
    
    func itemAt(index: Int) -> ContactsListResponse? {
        return contacts[index]
    }
    
    func didSelectContact(at index: Int) -> ContactsListResponse? {
        return contacts[index]
    }
}

struct ContactListViewModelFactory {
    static func create() -> ContactListViewModel {
        let provider = ContactListProviderFactory.create()
        return ContactListViewModel(provider: provider)
    }
}
