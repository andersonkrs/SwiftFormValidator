//
//  SwiftFormValidator.swift
//
//  Created by Anderson Macedo on 03/03/17.
//  Copyright © 2017 Anderson Macedo. All rights reserved.
//

import UIKit

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
