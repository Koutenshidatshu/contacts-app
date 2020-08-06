//
//  ContactsResponse.swift
//  contacts-APP
//
//  Created by Yonathan Wijaya on 06/08/20.
//  Copyright © 2020 Yonathan Wijaya. All rights reserved.
//

import Foundation
import RxSwift

struct ContactsListResponse : Decodable {
    enum CodingKeys : String, CodingKey {
        case id
        case fistname = "first_name"
        case lastname = "last_name"
        case favorite
        case profilepic = "profile_pic"
        case url
    }

    var id: Int?
    var fistname: String?
    var lastname: String?
    var favorite: Bool?
    var profilepic: String?
    var url: String?
}

extension ContactsListResponse {
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        fistname = try values.decodeIfPresent(String.self, forKey: .fistname)
        lastname = try values.decodeIfPresent(String.self, forKey: .lastname)
        favorite = try values.decodeIfPresent(Bool.self, forKey: .favorite)
        profilepic = try values.decodeIfPresent(String.self, forKey: .profilepic)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }
}


struct ContactListRequester {
    enum RequestError : Error {
        case parseFailure
    }
    
    let request: () -> Single<[ContactsListResponse]>
}

extension ContactListRequester {
    init(requestContacts: Observable<Data>) {
        request = {
            requestContacts
                .map { try ContactsListResponse.parseResponse(from: $0) }
                .take(1)
                .asSingle()
        }
    }
}

private extension ContactsListResponse {
    static func parseResponse(from data: Data) throws -> [ContactsListResponse] {
        do {
            return try JSONDecoder().decode([ContactsListResponse].self, from: data)
        } catch {
            throw ContactListRequester.RequestError.parseFailure
        }
    }
}
