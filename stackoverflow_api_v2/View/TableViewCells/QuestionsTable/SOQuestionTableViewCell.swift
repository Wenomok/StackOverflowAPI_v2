//
//  SOQuestionTableViewCell.swift
//  stackoverflow_api_v2
//
//  Created by Vladislav Ivshin on 31.08.2020.
//  Copyright © 2020 Vladislav Ivshin. All rights reserved.
//

import UIKit

class SOQuestionTableViewCell: UITableViewCell {
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

    func configure(question: SOQuestion) {
//        OperationQueue.main.addOperation {
            self.authorLabel.text = question.author
        self.titleLabel.attributedText = question.title.attributedHTMLString
//        }
    }
}
