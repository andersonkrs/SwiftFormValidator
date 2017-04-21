//
//  LengthRules.swift
//  SwiftFormValidator
//
//  Created by Anderson Macedo on 14/04/17.
//  Copyright © 2017 AndersonSKM. All rights reserved.
//

import UIKit

// MARK: - Length Rules

public protocol LengthRule: Rule {
    var length: Int { get set }
    init(length: Int, message: String)
    init(length: Int)
}

extension Rule where Self: LengthRule {
    public init(length: Int, message: String) {
        self.init(message: String(format: message, length))
        self.length = length
    }
    
    public init(length: Int) {
        self.init()
        self.length = length
    }
}

// MARK: - Max Length Rule

public class MaxLengthRule: LengthRule {
    public var errorMsg: String? =  "The field must contain a maximum of 20 characters"
    public var length: Int = 20
    
    required public init() {}
    
    public func validate(_ text: String) -> Bool {
        return text.characters.count <= self.length
    }
}

// MARK: - Min Length Rule

public class MinLengthRule: LengthRule {
    public var errorMsg: String? = "The field must contain a minimum of 5 characters"
    public var length: Int = 5
    
    required public init() {}
    
    public func validate(_ text: String) -> Bool {
        return text.characters.count >= self.length
    }
}

// MARK: - Equal Length Rule

public class EqualLengthRule: LengthRule {
    public var errorMsg: String? = "The field must contain exactly 10 characters"
    public var length: Int = 10
    
    required public init() {}
    
    public func validate(_ text: String) -> Bool {
        return text.characters.count == self.length
    }
}
