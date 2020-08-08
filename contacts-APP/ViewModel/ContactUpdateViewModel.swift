//
//  ContactUpdateViewModel.swift
//  contacts-APP
//
//  Created by Yonathan Wijaya on 08/08/20.
//  Copyright © 2020 Yonathan Wijaya. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ContactUpdateViewModel {
    
    lazy var contact: Observable<ContactUpdaterResponse> = contactRelay.asObservable()
    
    private let provider: ContactProviderUpdater
    private let disposeBag = DisposeBag()
    private let contactRelay = PublishRelay<ContactUpdaterResponse>()
    
    init(provider: ContactProviderUpdater) {
        self.provider = provider
    }
    
    func updateContact(id: Int, params: [String: Any]) {
        provider.updateContact(id: id, params: params)
            .subscribe(onNext: { [weak self] result in
                self?.contactRelay.accept(result)
            }).disposed(by: disposeBag)
    }
}
struct ContactUpdateViewModelFactory {
    static func create() -> ContactUpdateViewModel {
        let provider = ContactProviderUpdaterFactory.create()
        return ContactUpdateViewModel(provider: provider)
    }
}
