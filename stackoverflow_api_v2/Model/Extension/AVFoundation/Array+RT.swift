//
//  Array+RT.swift
//  mobile-au
//
//  Created by Vladislav Ivshin on 25.05.2020.
//  Copyright © 2020 HUDWAY. All rights reserved.
//

import UIKit

extension Array {
    public subscript(safeIndex index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }
        
        return self[index]
    }
}
