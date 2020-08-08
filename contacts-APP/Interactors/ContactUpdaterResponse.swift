//
//  ContactUpdaterResponse.swift
//  contacts-APP
//
//  Created by Yonathan Wijaya on 08/08/20.
//  Copyright © 2020 Yonathan Wijaya. All rights reserved.
//

import Foundation
import RxSwift

struct ContactUpdaterResponse: Decodable, Equatable {
    enum CodingKeys : String, CodingKey {
        case id
        case fistname = "first_name"
        case lastname = "last_name"
        case email
        case phoneNumber = "phone_number"
        case favorite
        case profilepic = "profile_pic"
        case url
    }

    var id: Int?
    var fistname: String?
    var lastname: String?
    var email: String?
    var phoneNumber: String?
    var favorite: Bool?
    var profilepic: String?
    var url: String?
}

extension ContactUpdaterResponse {
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        fistname = try values.decodeIfPresent(String.self, forKey: .fistname)
        lastname = try values.decodeIfPresent(String.self, forKey: .lastname)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        phoneNumber = try values.decodeIfPresent(String.self, forKey: .phoneNumber)
        favorite = try values.decodeIfPresent(Bool.self, forKey: .favorite)
        profilepic = try values.decodeIfPresent(String.self, forKey: .profilepic)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }
}

struct ContactUpdaterRequester {
    enum RequestError : Error {
        case parseFailure
    }
    
    let request: () -> Single<ContactUpdaterResponse>
}

extension ContactUpdaterRequester {
    init(requestContacts: Observable<Data>) {
        request = {
            requestContacts
                .map { try ContactUpdaterResponse.parseResponse(from: $0) }
                .take(1)
                .asSingle()
        }
    }
}

private extension ContactUpdaterResponse {
    static func parseResponse(from data: Data) throws -> ContactUpdaterResponse {
        do {
            return try JSONDecoder().decode(ContactUpdaterResponse.self, from: data)
        } catch {
            throw ContactUpdaterRequester.RequestError.parseFailure
        }
    }
}
