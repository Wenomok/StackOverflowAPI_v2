//
//  SODetailQuestionTableViewCell.swift
//  stackoverflow_api_v2
//
//  Created by Vladislav Ivshin on 04.09.2020.
//  Copyright © 2020 Vladislav Ivshin. All rights reserved.
//

import UIKit

class SODetailQuestionTableViewCell: UITableViewCell {
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var bodyQuestionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

    func configure(question: SOQuestion) {
        self.authorLabel.text = question.author
        self.bodyQuestionLabel.attributedText = question.body.attributedHTMLString
    }
}
