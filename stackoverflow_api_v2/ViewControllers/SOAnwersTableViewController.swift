//
//  SOAnwersTableViewController.swift
//  stackoverflow_api_v2
//
//  Created by Vladislav Ivshin on 31.08.2020.
//  Copyright © 2020 Vladislav Ivshin. All rights reserved.
//

import UIKit

enum AnswerQuestionTableType: Int {
    case question = 0
    case answer = 1
}

class SOAnwersTableViewController: VIViewController {
    
    private var dataSource: [AnswerQuestionTableType: [Any]] = [:]
    
    func configure(question: SOQuestion) {
        self.dataSource[AnswerQuestionTableType.question] = [question]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let question = self.dataSource[AnswerQuestionTableType.question]?.first as? SOQuestion {
            SONetworkManager.shared().getAnswers(forQuestionId: question.id) { (response) in
                switch response {
                case .success(let data):
                    print()
                case .failure(let error):
                    print()
                }
            }
        }
    }
}

extension SOAnwersTableViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataSource.keys.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tableType = AnswerQuestionTableType.init(rawValue: section) {
            return self.dataSource[tableType]?.count ?? 0
        }
        
        return 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let tableType = AnswerQuestionTableType.init(rawValue: indexPath.section) {
            
        }
        return UITableViewCell()
    }
}
