//
//  Constant.swift
//  stackoverflow_api_v2
//
//  Created by Vladislav Ivshin on 29.08.2020.
//  Copyright © 2020 Vladislav Ivshin. All rights reserved.
//

import UIKit

struct Constant {
    struct STACK_OVERFLOW_API {
        static let baseURL = "https://api.stackexchange.com/2.2/questions"
    }
    
    struct TABLE_VIEW_CELL_IDS {
        // MARK: Question list
        static let questionCell = "question_cell"
        
        // MARK: Detail question
        static let detailQuestionCell = "detail_question_cell"
        static let answerCell = "answer_cell"
    }
}
