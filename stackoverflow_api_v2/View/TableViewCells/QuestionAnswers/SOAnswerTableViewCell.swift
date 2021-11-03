//
//  SOAnswerTableViewCell.swift
//  stackoverflow_api_v2
//
//  Created by Vladislav Ivshin on 04.09.2020.
//  Copyright © 2020 Vladislav Ivshin. All rights reserved.
//

import UIKit

class SOAnswerTableViewCell: UITableViewCell {
    @IBOutlet weak var authorAnswerLabel: UILabel!
    @IBOutlet weak var bodyAnswerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

    func configure(answer: SOAnswer) {
        self.authorAnswerLabel.text = answer.author.name
        self.bodyAnswerLabel.attributedText = answer.body.attributedHTMLString
    }
}
