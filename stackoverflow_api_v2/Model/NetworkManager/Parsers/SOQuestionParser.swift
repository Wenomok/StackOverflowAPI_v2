//
//  SOQuestionParser.swift
//  stackoverflow_api_v2
//
//  Created by Vladislav Ivshin on 31.08.2020.
//  Copyright © 2020 Vladislav Ivshin. All rights reserved.
//

import UIKit

class SOQuestionParser: NSObject {
    func parseSOQuestions(witData data: Data) -> [SOQuestion]? {
        if let json = data.getJSONDict(),
            let items = json["items"] as? [[String: Any]] {
            
            var questions: [SOQuestion] = []
            for item in items {
                if let owner = item["owner"] as? [String: Any] {
                    if let id = item["question_id"] as? Int,
                        let title = item["title"] as? String,
                        let body = item["body"] as? String,
                        let author = owner["display_name"] as? String,
                        let lastEditDateTimeStamp = item["last_activity_date"] as? Double,
                        let answerCount = item["answer_count"] as? Int,
                        let score = item["score"] as? Int {
                        let question = SOQuestion.init(id: id, title: title, body: body,
                                                       author: author, lastEditDateTimeStamp: lastEditDateTimeStamp,
                                                       answerCount: answerCount, score: score)
                        questions.append(question)
                    }
                }
            }
            
            return questions
        }
        
        return nil
    }
}
