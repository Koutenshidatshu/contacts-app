//
//  ContactDetailViewModel.swift
//  contacts-APP
//
//  Created by Yonathan Wijaya on 07/08/20.
//  Copyright © 2020 Yonathan Wijaya. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ContactDetailViewModel {
    
    lazy var contact: Observable<ContactDetailResponse> = contactRelay.asObservable()
    
    private let provider: GetContactDetailProvider
    private let disposeBag = DisposeBag()
    private let contactRelay = PublishRelay<ContactDetailResponse>()
    
    init(provider: GetContactDetailProvider) {
        self.provider = provider
    }
    
    func fetchContactDetail(id: Int) {
        provider.getContactDetail(id: id)
            .subscribe(onNext: { [weak self] result in
                self?.contactRelay.accept(result)
            }).disposed(by: disposeBag)
    }
}
struct ContactDetailViewModelFactory {
    static func create() -> ContactDetailViewModel {
        let provider = GetContactDetailProviderFactory.create()
        return ContactDetailViewModel(provider: provider)
    }
}
