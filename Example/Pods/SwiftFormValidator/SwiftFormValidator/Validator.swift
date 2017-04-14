//
//  Validator.swift
//  MyMgr
//
//  Created by Anderson Macedo on 03/03/17.
//  Copyright © 2017 Anderson Macedo. All rights reserved.
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

// MARK: - Simple Rules

public class RequiredRule: Rule {
    public var errorMsg: String? = "This field is required"

    required public init () {}
    
    public func validate(_ text: String) -> Bool {
        return !text.isEmpty
    }
}

public class FullNameRule: Rule {
    public var errorMsg: String? = "Please provide a first and last name"
    
    required public init () {}
    
    public func validate(_ text: String) -> Bool {
        let nameArray: [String] = text.characters.split { $0 == " " }.map { String($0) }
        return nameArray.count >= 2
    }
}

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

// MARK: - CaracterSet Rules 

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

public class AlphaRule: CharacterSetRule {
    public var errorMsg: String? = "Enter valid alphabetic characters"
    public var characterSet: CharacterSet = CharacterSet.letters

    required public init() { }
}

public class AlphaNumericRule: CharacterSetRule {
    public var errorMsg: String? = "Enter valid numeric characters"
    public var characterSet: CharacterSet = CharacterSet.alphanumerics
    
    required public init() { }
}


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


public class ProductKeyRule: RegexRule {
    public var errorMsg: String? = "Invalid product key"
    public var regex: String = "[A-Z0-9]{4}-[A-Z0-9]{4}-[A-Z0-9]{4}-[A-Z0-9]{4}"
    
    required public init() {}
}

public class EmailRule: RegexRule {
    public var errorMsg: String? = "Invalid e-mail"
    public var regex: String = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
    
    required public init() {}
}

public class WeakPasswordRule: RegexRule {
    public var errorMsg: String? = "Invalid password"
    public var regex: String = "^(?=.*?[a-z])(?=.*?[A-Z]).*$"
    
    required public init() {}
}

public class MediumPasswordRule: RegexRule {
    public var errorMsg: String? = "Invalid password"
    public var regex: String = "^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[a-z]).{8,}$"
    
    required public init() {}
}

public class StrongPasswordRule: RegexRule {
    public var errorMsg: String? = "Invalid password"
    public var regex: String = "^(?=.*[a-z])(?=.*[A-Z])(?=.*?[0-9])(?=.*[$@$!%*?&])[A-Za-z0-9$@$!%*?&]{8,}"
    
    required public init() {}
}

public class Ipv4Rule: RegexRule {
    public var errorMsg: String? = "Enter a valid IPV4 adress"
    public var regex: String = "^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$"
    
    required public init() {}
}


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

public class MaxLengthRule: LengthRule {
    public var errorMsg: String? =  "The field must contain a maximum of 20 characters"
    public var length: Int = 20
    
    required public init() {}
    
    public func validate(_ text: String) -> Bool {
        return text.characters.count <= self.length
    }
}

public class MinLengthRule: LengthRule {
    public var errorMsg: String? = "The field must contain a minimum of 5 characters"
    public var length: Int = 5
    
    required public init() {}
    
    public func validate(_ text: String) -> Bool {
        return text.characters.count >= self.length
    }
}

public class EqualLengthRule: LengthRule {
    public var errorMsg: String? = "The field must contain exactly 10 characters"
    public var length: Int = 10
    
    required public init() {}
    
    public func validate(_ text: String) -> Bool {
        return text.characters.count == self.length
    }
}

// MARK: - Validator Class and Utils

public struct Validation {
    public var control: UITextField!
    public var label: UILabel?
    public var rules: [Rule]!
}

public struct ValidationResult {
    public var control: UITextField!
    public var label: UILabel?
    public var rule: Rule?
}

public protocol ValidatorDelegate {
    func validationSucess() -> Void
    func validation(sucess: Bool, validations: [ValidationResult]) -> Bool
}

public class Validator {
    
    private var list = [Validation]()
    
    public var delegate: ValidatorDelegate? = nil
    
    public init(delegate: ValidatorDelegate) {
        self.delegate = delegate
    }
    
    public init() { }
    
    public func register(control: UITextField, label: UILabel? = nil, rules: [Rule]) -> Void {
        
        if list.filter({ (val) -> Bool in return val.control == control }).count > 0 {
            self.unregister(control: control)
        }
    
        self.list.append(Validation(control: control, label: label, rules: rules))
    }
    
    public func unregister(control: UITextField) -> Void {
        var array = list.filter { $0.control == control }
        array.removeAll()
    }
    
    
    public func rules(forControl: UITextField) -> [Rule]? {
        return list.filter { $0.control == forControl }.first?.rules
    }
    
    public func validate(control: UITextField) -> ValidationResult {
        
        let validation = self.list.filter { $0.control == control }.first
        
        let text = validation?.control.text ?? ""
        
        return ValidationResult(
            control: control,
            label: validation?.label,
            rule: validation?.rules.filter { !$0.validate(text) }.first
        )
    }
    
    public func validateAll() -> Void {
        
        let array = list.map {
            self.validate(control: $0.control)
        }
        
        if self.delegate != nil {
            
            let sucess = array.filter { $0.rule != nil }.count == 0

            if delegate!.validation(sucess: sucess, validations: array) && sucess {
                self.delegate?.validationSucess()
            }
        }
    }
    
}
