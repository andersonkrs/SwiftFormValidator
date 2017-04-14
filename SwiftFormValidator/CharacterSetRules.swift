//
//  CharacterSetRules.swift
//  SwiftFormValidator
//
//  Created by Anderson Macedo on 14/04/17.
//  Copyright © 2017 AndersonSKM. All rights reserved.
//

import UIKit

// MARK: - CharacterSet Rules

public protocol CharacterSetRule: Rule {
    var characterSet: CharacterSet { get set }
    init(characterSet: CharacterSet)
    init(message: String, characterSet: CharacterSet)
}

extension Rule where Self: CharacterSetRule {
    public init(characterSet: CharacterSet) {
        self.init()
        self.characterSet = characterSet
    }
    
    public init(message: String, characterSet: CharacterSet) {
        self.init(message: message)
        self.characterSet = characterSet
    }
    
    public func validate(_ text: String) -> Bool {
        
        if text.rangeOfCharacter(from: characterSet.inverted ) != nil {
            return false
        }
        
        return true
    }
}

// MARK: - Alpha Rule

public class AlphaRule: CharacterSetRule {
    public var errorMsg: String? = "Enter valid alphabetic characters"
    public var characterSet: CharacterSet = CharacterSet.letters
    
    required public init() { }
}

// MARK: - Alpha Numeric Rule

public class AlphaNumericRule: CharacterSetRule {
    public var errorMsg: String? = "Enter valid numeric characters"
    public var characterSet: CharacterSet = CharacterSet.alphanumerics
    
    required public init() { }
}
