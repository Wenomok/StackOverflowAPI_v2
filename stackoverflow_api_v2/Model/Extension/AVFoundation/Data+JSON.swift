//
//  Data+JSON.swift
//  stackoverflow_api_v2
//
//  Created by Vladislav Ivshin on 31.08.2020.
//  Copyright © 2020 Vladislav Ivshin. All rights reserved.
//

import UIKit

extension Data {
    func getJSONDict() -> [String: Any]? {
        do {
            let json = try JSONSerialization.jsonObject(with: self, options: .allowFragments)
            if JSONSerialization.isValidJSONObject(json) {
                return json as? [String: Any]
            }
            return nil
        } catch {
            return nil
        }
        
    }
}
