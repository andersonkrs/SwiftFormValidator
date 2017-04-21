//
//  RegexRules.swift
//  SwiftFormValidator
//
//  Created by Anderson Macedo on 14/04/17.
//  Copyright © 2017 AndersonSKM. All rights reserved.
//

import UIKit

// MARK: - Regex Rules

public protocol RegexRule: Rule {
    var regex: String { get set }
    init(regex: String)
    init(message: String, regex: String)
}

extension Rule where Self: RegexRule {
    public init(regex: String) {
        self.init()
        self.regex = regex
    }
    
    public init(message: String, regex: String) {
        self.init(message: message)
        self.regex = regex
    }
    
    public func validate(_ text: String) -> Bool {
        let testStr = NSPredicate(format:"SELF MATCHES %@", regex)
        return testStr.evaluate(with: text)
    }
}

// MARK: - Product Key Rule

public class ProductKeyRule: RegexRule {
    public var errorMsg: String? = "Invalid product key"
    public var regex: String = "[A-Z0-9]{4}-[A-Z0-9]{4}-[A-Z0-9]{4}-[A-Z0-9]{4}"
    
    required public init() {}
}

// MARK: - Email Rule

public class EmailRule: RegexRule {
    public var errorMsg: String? = "Invalid e-mail"
    public var regex: String = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
    
    required public init() {}
}

// MARK: - Weak Password Rule

public class WeakPasswordRule: RegexRule {
    public var errorMsg: String? = "Invalid password"
    public var regex: String = "^(?=.*?[a-z])(?=.*?[A-Z]).*$"
    
    required public init() {}
}

// MARK: - Medium Password Rule

public class MediumPasswordRule: RegexRule {
    public var errorMsg: String? = "Invalid password"
    public var regex: String = "^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[a-z]).{8,}$"
    
    required public init() {}
}

// MARK: - Strong Password Rule

public class StrongPasswordRule: RegexRule {
    public var errorMsg: String? = "Invalid password"
    public var regex: String = "^(?=.*[a-z])(?=.*[A-Z])(?=.*?[0-9])(?=.*[$@$!%*?&])[A-Za-z0-9$@$!%*?&]{8,}"
    
    required public init() {}
}

// MARK: - IPV4 Rule

public class Ipv4Rule: RegexRule {
    public var errorMsg: String? = "Enter a valid IPV4 adress"
    public var regex: String = "^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$"
    
    required public init() {}
}
