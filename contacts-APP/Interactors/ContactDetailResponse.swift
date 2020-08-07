//
//  ContactDetailResponse.swift
//  contacts-APP
//
//  Created by Yonathan Wijaya on 07/08/20.
//  Copyright © 2020 Yonathan Wijaya. All rights reserved.
//

import Foundation
import RxSwift

struct ContactDetailResponse: Decodable, Equatable {
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

extension ContactDetailResponse {
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

struct ContactDetailRequester {
    enum RequestError : Error {
        case parseFailure
    }
    
    let request: () -> Single<ContactDetailResponse>
}

extension ContactDetailRequester {
    init(requestContacts: Observable<Data>) {
        request = {
            requestContacts
                .map { try ContactDetailResponse.parseResponse(from: $0) }
                .take(1)
                .asSingle()
        }
    }
}

private extension ContactDetailResponse {
    static func parseResponse(from data: Data) throws -> ContactDetailResponse {
        do {
            return try JSONDecoder().decode(ContactDetailResponse.self, from: data)
        } catch {
            throw ContactDetailRequester.RequestError.parseFailure
        }
    }
}
