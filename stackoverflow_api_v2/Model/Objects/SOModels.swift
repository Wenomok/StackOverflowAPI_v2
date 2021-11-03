//
//  SOQuestion.swift
//  stackoverflow_api_v2
//
//  Created by Vladislav Ivshin on 31.08.2020.
//  Copyright © 2020 Vladislav Ivshin. All rights reserved.
//

import UIKit

protocol CommonResponse: Decodable {
    var hasMore: Bool { get }
}

struct AnswersResponse: CommonResponse {
    var hasMore: Bool
    var items: [SOAnswer]?
    
    enum CodingKeys: String, CodingKey {
        case hasMore = "has_more"
        case items = "items"
    }
}

protocol SOObject: Decodable {
//    var id: Int { get }
    
    var body: String { get }
    
//    var author: String { get }
    
//    var lastEditDateTimeStamp: Double { get }
    var score: Int { get }
}

struct SOQuestion: SOObject {
    var id: Int
    
    var title: String
    var body: String
    
    var author: String
    
    var lastEditDateTimeStamp: Double
    
    var score: Int
    
    let isAnswered: Bool
    
    var answerCount: Int
}

struct SOAnswer: Decodable {
    var id: Int
    
    var author: SOOwner
    
    var body: String
    
    var lastEditDateTimeStamp: Double
    
    var score: Int
    
    let isAccepted: Bool
    
    enum CodingKeys: String, CodingKey {
        case id = "answer_id"
        case lastEditDateTimeStamp = "last_activity_date"
        case isAccepted = "is_accepted"
        case score, body
        case author = "owner"
    }
}

struct SOOwner: Decodable {
    var profileImage: String
    var userId: Int
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case profileImage = "profile_image"
        case userId = "user_id"
        case name = "display_name"
    }
}
