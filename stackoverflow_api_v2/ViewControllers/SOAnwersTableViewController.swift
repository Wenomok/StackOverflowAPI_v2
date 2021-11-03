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
    @IBOutlet weak var answersTableView: UITableView!
    
    private var dataSource: [AnswerQuestionTableType: [Any]] = [:]
    
    func configure(question: SOQuestion) {
        self.dataSource[AnswerQuestionTableType.question] = [question]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let question = self.dataSource[AnswerQuestionTableType.question]?.first as? SOQuestion {
            SONetworkManager.shared().getAnswers(forQuestionId: Int(question.id)) { (response) in
                switch response {
                case .success(let data):
                    let answers = SOQuestionParser().parseSOAnswers(withData: data)
                    self.dataSource[.answer] = answers
                    
                    OperationQueue.main.addOperation {
                        self.answersTableView.reloadData()
                    }
                case .failure(let error):
                    self.showOkAlert(withMessage: error.localizedDescription)
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
            if tableType == .question, let question = self.dataSource[tableType]?.first as? SOQuestion {
                let questionTableViewCell = tableView.dequeueReusableCell(withIdentifier: Constant.TABLE_VIEW_CELL_IDS.detailQuestionCell,
                                                                          for: indexPath) as! SODetailQuestionTableViewCell
                questionTableViewCell.configure(question: question)
                
                return questionTableViewCell
            } else if tableType == .answer, let answer = self.dataSource[tableType]?[safeIndex: indexPath.row] as? SOAnswer {
                let answerTableViewCell = tableView.dequeueReusableCell(withIdentifier: Constant.TABLE_VIEW_CELL_IDS.answerCell,
                                                                        for: indexPath) as! SOAnswerTableViewCell
                answerTableViewCell.configure(answer: answer)
                
                return answerTableViewCell
            }
        }
        return UITableViewCell()
    }
}
