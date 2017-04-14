//
//  BaseRule.swift
//  SwiftFormValidator
//
//  Created by Anderson Macedo on 14/04/17.
//  Copyright © 2017 AndersonSKM. All rights reserved.
//

import UIKit


// MARK: - Base Rule Protocol

public protocol Rule: class {
    var errorMsg: String? { get set }
    
    init ()
    init(message: String)
    func validate(_ text: String) -> Bool
}

extension Rule {
    public init(message: String) {
        self.init()
        self.errorMsg = message
    }
}
