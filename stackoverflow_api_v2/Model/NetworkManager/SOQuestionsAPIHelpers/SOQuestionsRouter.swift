//
//  SOQuestionsRouter.swift
//  stackoverflow_api_v2
//
//  Created by Vladislav Ivshin on 29.08.2020.
//  Copyright © 2020 Vladislav Ivshin. All rights reserved.
//

import UIKit
import Alamofire

//@"https://api.stackexchange.com/2.2/questions?page=%i&pagesize=50&order=desc&sort=activity&tagged=%@&site=stackoverflow&filter=!9YdnSJ*Wh"

enum SOQuestionsRouter: URLRequestConvertible {
    case getQuestions(page: Int, tag: String)
    case getAnswersForQuestion(id: Int)
    
    private var method: HTTPMethod {
        switch self {
        case .getQuestions:
            return .get
        case .getAnswersForQuestion:
            return .get
        }
    }
    private var urlPart: String {
        switch self {
        case .getQuestions:
            return ""
        case .getAnswersForQuestion(let id):
            return "\(id)/answers"
        }
    }
    private var parameters: Parameters? {
        switch self {
        case .getQuestions(let page, let tag):
            var defaultParameters = self.defaultParameters()
            defaultParameters["page"] = page
            defaultParameters["tagged"] = tag
            defaultParameters["pagesize"] = 50
            defaultParameters["filter"] = "!9YdnSJ*Wh"
            return defaultParameters
        case .getAnswersForQuestion:
            var defaultParameters = self.defaultParameters()
            defaultParameters["filter"] = "!9YdnSMKKT"
            return defaultParameters
        }
    }
    
    private func defaultParameters() -> [String: Any] {
        return ["order": "desc",
                "sort": "activity",
                "site": "stackoverflow"]
    }
    
    func asURLRequest() throws -> URLRequest {
        var baseURL = try Constant.STACK_OVERFLOW_API.baseURL.asURL()
        baseURL = baseURL.appendingPathComponent(urlPart)
        var request = URLRequest.init(url: baseURL)
        
        request.httpMethod = method.rawValue
        request = try URLEncoding.queryString.encode(request, with: parameters)
        
        return request
    }
}
