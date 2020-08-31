//
//  SONetworkManager.swift
//  stackoverflow_api_v2
//
//  Created by Vladislav Ivshin on 29.08.2020.
//  Copyright © 2020 Vladislav Ivshin. All rights reserved.
//

import UIKit
import Alamofire

class SONetworkManager: NSObject {
    private static let instance: SONetworkManager = SONetworkManager()
    
    static func shared() -> SONetworkManager {
        return instance
    }
    
    @discardableResult
    private func performRequest(route: SOQuestionsRouter, completion: ((DefaultResponse) -> ())?) -> DataRequest {
        return AF.request(route).validate(statusCode: 200..<300).responseData { (response) in
            switch response.result {
            case .success(let data):
                completion?(.success(data: data))
            case .failure(let error):
                completion?(.failure(error: error))
            }
        }
    }
    
    func getQuestions(byTag tag: String, atPage page: Int, completion: ((DefaultResponse) -> ())?) {
        performRequest(route: .getQuestions(page: page, tag: tag)) { (response) in
            switch response {
            case .success(let data):
                completion?(.success(data: data))
            case .failure(let error):
                completion?(.failure(error: error))
            }
        }
    }
    
    func getAnswers(forQuestionId id: Int, completion: ((DefaultResponse) -> ())?) {
        performRequest(route: .getAnswersForQuestion(id: id)) { (response) in
            switch response {
            case .success(let data):
                completion?(.success(data: data))
            case .failure(let error):
                completion?(.failure(error: error))
            }
        }
    }
}
