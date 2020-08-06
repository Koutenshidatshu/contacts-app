//
//  ContactsApi.swift
//  contacts-APP
//
//  Created by Yonathan Wijaya on 06/08/20.
//  Copyright © 2020 Yonathan Wijaya. All rights reserved.
//

import Foundation

struct ContactsApi {
    let path: String
    init() {
        path = "http://gojek-contacts-app.herokuapp.com/contacts.json"
    }
}
