//
//  Foundation+Extensions.swift
//  oly
//
//  Created by Niranjan Ravichandran on 9/28/18.
//  Copyright © 2018 Aviato. All rights reserved.
//

import Foundation

extension Optional where Wrapped: Collection {
    
    func nilOrEmptyCollection() -> Bool {
        guard let value = self else { return true }
        return value.isEmpty
    }
    
    func hasElements() -> Bool {
        return !nilOrEmptyCollection()
    }
}

