//
//  String+SO.swift
//  stackoverflow_api_v2
//
//  Created by Vladislav Ivshin on 04.09.2020.
//  Copyright © 2020 Vladislav Ivshin. All rights reserved.
//

import UIKit

extension String {
    var attributedHTMLString: NSAttributedString? {
        let str = self.appending("<style>body{font-family: 'Helvetica'; font-size:19px;}</style>")
        let data = Data.init(str.utf8)
        
        if let attributedString = try? NSMutableAttributedString.init(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
//            attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 15.0), range: NSRange.init(location: 0, length: attributedString.string.count))
            return NSAttributedString.init(attributedString: attributedString)
        }
        
        return nil
    }
}
