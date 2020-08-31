//
//  ViewController.swift
//  stackoverflow_api_v2
//
//  Created by Vladislav Ivshin on 29.08.2020.
//  Copyright © 2020 Vladislav Ivshin. All rights reserved.
//

import UIKit

class SOQuestionsTableViewController: VIViewController {
    @IBOutlet weak var questionsTableView: UITableView!
    
    private var questions: [SOQuestion] = [] {
        didSet {
            OperationQueue.main.addOperation {
                self.questionsTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        SONetworkManager.shared().getQuestions(byTag: "iPhone", atPage: 1, completion: { questionsResponse in
            switch questionsResponse {
            case .success(let data):
                if let questions = SOQuestionParser().parseSOQuestions(witData: data) {
                    self.questions = questions
                }
            case .failure(let error):
                self.showOkAlert(withMessage: error.localizedDescription)
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let answerTableViewController = segue.destination as? SOAnwersTableViewController,
            let indexPath = self.questionsTableView.indexPathForSelectedRow,
            let question = questions[safeIndex: indexPath.row] {
            answerTableViewController.configure(question: question)
        }
    }
}

extension SOQuestionsTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let questionCell = tableView.dequeueReusableCell(withIdentifier: Constant.TABLE_VIEW_CELL_IDS.questionCell, for: indexPath) as? SOQuestionTableViewCell,
            let question = questions[safeIndex: indexPath.row] {
            
            questionCell.configure(question: question)
            return questionCell
        }
        
        return UITableViewCell()
    }
}
