//
//  Observable+GetEmit.swift
//  contacts-APP
//
//  Created by Yonathan Wijaya on 06/08/20.
//  Copyright © 2020 Yonathan Wijaya. All rights reserved.
//

import RxSwift
import RxBlocking

extension Observable {
    func firstEmit() -> Element? {
        return try? toBlocking().first()
    }
    
    func allEmit() -> [Element]? {
        return try? toBlocking().toArray()
    }
}
