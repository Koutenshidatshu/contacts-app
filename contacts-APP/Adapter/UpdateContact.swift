//
//  UpdateContact.swift
//  contacts-APP
//
//  Created by Yonathan Wijaya on 08/08/20.
//  Copyright © 2020 Yonathan Wijaya. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol UpdateContact {
    func getContactId(id: Int, params: [String: Any])
    -> Observable<Data>
}

struct UpdateContactImpl: UpdateContact {
    private var urlString = "http://gojek-contacts-app.herokuapp.com/contacts/"
    func getContactId(id: Int, params: [String: Any])
        -> Observable<Data> {
            
            let session = URLSession.shared
            guard let urlRequest = requestUrl(id: id, params: params)
                else { return .error(RxCocoaError.unknown) }
            let data = session.rx.response(request: urlRequest )
                .map { (_, data) in
                    return data
            }.retry(2)
            return handleApiRequestFailed(data)
    }
    
    private func requestUrl(id: Int, params: [String: Any]) -> URLRequest? {
        guard JSONSerialization.isValidJSONObject(params) else { return nil }
        let urlPathString = urlString + "\(id)" + ".json"
        let url = URL(string: urlPathString)!
        
        let mutableURLRequest = NSMutableURLRequest(url: url)
        mutableURLRequest.httpMethod = "PUT"
        mutableURLRequest.addValue("application/json",forHTTPHeaderField: "Content-Type")
        mutableURLRequest.addValue("application/json",forHTTPHeaderField: "Accept")
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: params)
            mutableURLRequest.httpBody = jsonData
            return mutableURLRequest as URLRequest
        } catch {
            return nil
        }
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
