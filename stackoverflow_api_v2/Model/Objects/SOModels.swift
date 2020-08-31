//
//  SOQuestion.swift
//  stackoverflow_api_v2
//
//  Created by Vladislav Ivshin on 31.08.2020.
//  Copyright © 2020 Vladislav Ivshin. All rights reserved.
//

import UIKit

struct SOObject {
    let questionId: Int
    
    let body: String
    
    let author: String
    
    let lastEditDateTimeStamp: Double
    let answerCount: Int
    let score: Int
}

struct SOQuestion: SOObject {
    let id: Int
    
    let title: String
    let body: String
    
    let author: String
    
    let lastEditDateTimeStamp: Double
    let answerCount: Int
    let score: Int
}
