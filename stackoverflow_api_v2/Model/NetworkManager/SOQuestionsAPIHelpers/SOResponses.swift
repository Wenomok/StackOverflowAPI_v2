//
//  Responses.swift
//  stackoverflow_api_v2
//
//  Created by Vladislav Ivshin on 29.08.2020.
//  Copyright © 2020 Vladislav Ivshin. All rights reserved.
//

import UIKit

enum DefaultResponse {
    case success(data: Data)
    case failure(error: Error)
}

enum QuestionByTagResponse {
    case success(questions: [SOQuestion], hasMore: Bool)
    case failure(error: Error)
}
