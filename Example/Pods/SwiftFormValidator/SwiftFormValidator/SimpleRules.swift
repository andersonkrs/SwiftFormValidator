//
//  SimpleRules.swift
//  SwiftFormValidator
//
//  Created by Anderson Macedo on 14/04/17.
//  Copyright © 2017 AndersonSKM. All rights reserved.
//

import UIKit

// MARK: - Simple Rules

// MARK: - Required Rule

public class RequiredRule: Rule {
    public var errorMsg: String? = "This field is required"
    
    required public init () {}
    
    public func validate(_ text: String) -> Bool {
        return !text.isEmpty
    }
}

// MARK: - Full Name Rule

public class FullNameRule: Rule {
    public var errorMsg: String? = "Please provide a first and last name"
    
    required public init () {}
    
    public func validate(_ text: String) -> Bool {
        let nameArray: [String] = text.characters.split { $0 == " " }.map { String($0) }
        return nameArray.count >= 2
    }
}

// MARK: - Confirm Rule

public class ConfirmRule: Rule {
    public var errorMsg: String?
    public var confirmField: UITextField!
    
    required public init () {
        errorMsg = "This field does not match"
    }
    
    public convenience init(confirmField: UITextField) {
        self.init()
        self.confirmField = confirmField
    }
    
    public convenience init(message: String, confirmField: UITextField) {
        self.init(message: message)
        self.confirmField = confirmField
    }
    
    public func validate(_ text: String) -> Bool {
        return (confirmField.text ?? "") == text
    }
}
