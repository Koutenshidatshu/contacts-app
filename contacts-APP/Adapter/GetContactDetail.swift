//
//  GetContactDetail.swift
//  contacts-APP
//
//  Created by Yonathan Wijaya on 07/08/20.
//  Copyright © 2020 Yonathan Wijaya. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol GetContactDetail {
    func getContactId(id: Int) -> Observable<Data>
}

struct GetContactDetailImpl: GetContactDetail {
    private var urlString = "http://gojek-contacts-app.herokuapp.com/contacts/"
    func getContactId(id: Int) -> Observable<Data> {
        let session = URLSession.shared
        let data = session.rx.response(request: requestUrl(id: id))
            .map { (_, data) in
                return data
        }.retry(2)
        return handleApiRequestFailed(data)
    }
    
    private func requestUrl(id: Int) -> URLRequest {
        let urlPathString = urlString + "\(id)" + ".json"
        let url = URL(string: urlPathString)!
        let urlRequest = URLRequest(url: url)
        return urlRequest
    }
    
    private func handleApiRequestFailed(_ observable: Observable<Data>) -> Observable<Data> {
        return observable.catchError { error -> Observable<Data> in
            if case let .httpRequestFailed(_, data)? = error as? RxCocoaURLError {
                return Observable.from(optional: data)
            } else {
                return .error(error)
            }
        }
    }
}
