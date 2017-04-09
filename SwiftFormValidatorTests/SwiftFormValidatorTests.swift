//
//  SwiftFormValidatorTests.swift
//  SwiftFormValidatorTests
//
//  Created by Anderson Macedo on 12/03/17.
//  Copyright © 2017 AndersonSKM. All rights reserved.
//

import XCTest
import UIKit

@testable import SwiftFormValidator

class SwiftFormValidatorTests: XCTestCase {
    
    private class ValidatorDelegateViewController: UIViewController, ValidatorDelegate {
        func validationSucess() -> Void { }
        
        func validation(sucess: Bool, validations: [ValidationResult]) -> Bool {
            return true
        }
    }
    
    private var registerValidator: Validator!
    private var registerField: UITextField!
    
    private var unregisterValdiator: Validator!
    private var unregisterField: UITextField!
    
    private var initDelegateValidator: Validator!
    private var initDelegateViewDelegate: ValidatorDelegateViewController!
    
    private var rulesForControlValdiator: Validator!
    private var rulesForControlField: UITextField!
    private var rulesForControlRules: [Rule]!

    private var rulesProtocolRule: [Rule]!
    private var rulesProtocolRegexRule: [RegexRule]!
    private var rulesProtocolLengthRule: [LengthRule]!
    
    private var validRequiredRuleText: String!
    private var invalidRequiredRuleText: String!
    
    private var validFullNameRuleText: String!
    private var invalidFullNameRuleText: String!
    
    private var validProductKeyRuleText: String!
    private var invalidProductKeyRuleText: String!
    
    private var validEmailRuleText: String!
    private var invalidEmailRuleText: String!
    
    private var validWeakPassWordRuleText: String!
    private var invalidWeakPassWordRuleText: String!
    
    private var validMediumPasswordRuleText: String!
    private var invalidMediumPasswordRuleText: String!
    
    private var validStrongPasswordRuleText: String!
    private var invalidStrongPasswordRuleText: String!
    
    private var validMaxLengthRuleText: String!
    private var invalidMaxLengthRuleText: String!
    
    private var validMinLengthRuleText: String!
    private var invalidMinLengthRuleText: String!
    
    private var validEqualLengthRuleText: String!
    private var invalidEqualLengthRuleTextMore: String!
    private var invalidEqualLengthRuleTextLess: String!
    
    private var validAlphaRuleText: String!
    private var invalidAlphaRuleText: String!
    
    private var validAlphaNumericRuleText: String!
    private var invalidAlphaNumericRuleText: String!
    
    private var validIpv4RuleTexts: [String]!
    private var invalidIpv4RuleTexts: [String]!
    
    private var validConfirmRuleFields: (field1: UITextField, field2: UITextField)!
    private var invalidConfirmRuleFields: (field1: UITextField, field2: UITextField)!
    
    private class ValidateAllViewController: UIViewController, ValidatorDelegate {
        
        public let fieldName = UITextField()
        public let fieldFullName = UITextField()
        public let fieldEmail = UITextField()
        public let fieldPasswd = UITextField()
        public let validator = Validator()
        
        private var _validated: Bool = false
        
        var Validated: Bool {
            return _validated
        }
        
        func validationSucess() -> Void {
            _validated = true
        }
        
        func validation(sucess: Bool, validations: [ValidationResult]) -> Bool {
            return sucess
        }
        
        func register() -> Void {
            validator.delegate = self
            validator.register(control: fieldName, rules: [RequiredRule()])
            validator.register(control: fieldFullName, rules: [FullNameRule()])
            validator.register(control: fieldEmail, rules: [EmailRule()])
            validator.register(control: fieldPasswd, rules: [WeakPasswordRule()])
        }
        
        func submitForm() -> Void {
            validator.validateAll()
        }
    }
    
    private var validViewController: ValidateAllViewController!
    private var invalidViewController: ValidateAllViewController!

    override func setUp() {
        
        super.setUp()
        
        registerValidator = Validator()
        registerField = UITextField()
        
        unregisterValdiator = Validator()
        unregisterField = UITextField()
        
        initDelegateViewDelegate = ValidatorDelegateViewController()
        initDelegateValidator = Validator(delegate: initDelegateViewDelegate)
        
        rulesForControlValdiator = Validator()
        rulesForControlField = UITextField()
        rulesForControlRules = [RequiredRule(), EmailRule(), MinLengthRule()]
        
        rulesProtocolRule = [RequiredRule(message: "Custom Msg"),
                             FullNameRule(message: "Custom Msg"),
                             EmailRule(message: "Custom Msg"),
                             MinLengthRule(message: "Custom Msg")]
        
        rulesProtocolRegexRule = [EmailRule(regex: "^[a-zA-Z0-9_]*$"),
                                  ProductKeyRule(regex: "^[a-zA-Z0-9_]*$"),
                                  WeakPasswordRule(regex: "^[a-zA-Z0-9_]*$"),
                                  MediumPasswordRule(regex: "^[a-zA-Z0-9_]*$"),
                                  StrongPasswordRule(regex: "^[a-zA-Z0-9_]*$")]
        
        rulesProtocolLengthRule = [MinLengthRule(length: 10),
                                   MaxLengthRule(length: 10),
                                   EqualLengthRule(length: 10)]
        
        validRequiredRuleText = "Some Text"
        invalidRequiredRuleText = ""
        
        validFullNameRuleText = "Bruce Wayne"
        invalidFullNameRuleText = "Bruce"
        
        validProductKeyRuleText = "1DH3-LU9D-45FS-ZJG9"
        invalidProductKeyRuleText = "A_&2-1242-AAAA"
        
        validEmailRuleText = "bruce@we.com"
        invalidEmailRuleText = "Bruce_@$@!wayne."
        
        validWeakPassWordRuleText = "Secret"
        invalidWeakPassWordRuleText = "secret"
        
        validMediumPasswordRuleText = "Secret123"
        invalidMediumPasswordRuleText = "Secret"
        
        validStrongPasswordRuleText = "Secr3tPa$$"
        invalidStrongPasswordRuleText = "Secret123"
        
        validMaxLengthRuleText = "12345"
        invalidMaxLengthRuleText = "123456"
        
        validMinLengthRuleText = "12345"
        invalidMinLengthRuleText = "1234"
        
        validEqualLengthRuleText = "12345"
        invalidEqualLengthRuleTextMore = "123456"
        invalidEqualLengthRuleTextLess = "1234"
        
        validAlphaRuleText = "Abcdefg"
        invalidAlphaRuleText = "A1bc2e3f4g5"
        
        validAlphaNumericRuleText = "aBcD123"
        invalidAlphaNumericRuleText = "abc$%#¨$%defg"
        
        validIpv4RuleTexts = ["0.0.0.0" ,  "255.255.255.255" , "192.168.0.1", "127.0.0.1"]
        invalidIpv4RuleTexts = ["123.a.123.b", "123 . 12312.123.1", " 2. .2 . 2", "255,255.266.1"]
        
        validConfirmRuleFields = (field1: UITextField(), field2: UITextField())
        validConfirmRuleFields.field1.text = "same"
        validConfirmRuleFields.field2.text = "same"
        
        invalidConfirmRuleFields = (field1: UITextField(), field2: UITextField())
        invalidConfirmRuleFields.field1.text = "same"
        invalidConfirmRuleFields.field2.text = "diferent"
        
        validViewController = ValidateAllViewController()
        invalidViewController = ValidateAllViewController()
        
    }
    
    override func tearDown() {
        
        registerValidator = nil
        registerField = nil
        
        unregisterValdiator = nil
        unregisterField = nil
        
        initDelegateValidator = nil
        initDelegateViewDelegate = nil
        
        rulesForControlValdiator = nil
        rulesForControlField = nil
        rulesForControlRules = nil
        
        rulesProtocolRule = nil
        rulesProtocolRegexRule = nil
        rulesProtocolLengthRule = nil
        
        validRequiredRuleText = nil
        invalidRequiredRuleText = nil
        
        validFullNameRuleText = nil
        invalidFullNameRuleText = nil
        
        validProductKeyRuleText = nil
        invalidProductKeyRuleText = nil
        
        validEmailRuleText = nil
        invalidEmailRuleText = nil
        
        validWeakPassWordRuleText = nil
        invalidWeakPassWordRuleText = nil
        
        validMediumPasswordRuleText = nil
        invalidMediumPasswordRuleText = nil
        
        validStrongPasswordRuleText = nil
        invalidStrongPasswordRuleText = nil
        
        validMaxLengthRuleText = nil
        invalidMaxLengthRuleText = nil
        
        validMinLengthRuleText = nil
        invalidMinLengthRuleText = nil
        
        validEqualLengthRuleText = nil
        invalidEqualLengthRuleTextMore = nil
        invalidEqualLengthRuleTextLess = nil
        
        validAlphaRuleText = nil
        invalidAlphaRuleText = nil
        
        validAlphaNumericRuleText = nil
        invalidAlphaNumericRuleText = nil
        
        validIpv4RuleTexts = nil
        invalidIpv4RuleTexts = nil
        
        validConfirmRuleFields = nil
        invalidConfirmRuleFields = nil
        
        validViewController = nil
        invalidViewController = nil
        
        super.tearDown()
    }
    
    // MARK: Register
    
    func testRegisterField() {
        registerValidator.register(control: registerField, rules: [RequiredRule()])
        XCTAssertNotNil(registerValidator.rules(forControl: registerField), "Field should register")
    }
    
    // MARK: Unregister
    
    func testUnregisterField() {
        unregisterValdiator.register(control: unregisterField, rules: [RequiredRule()])
        XCTAssertNil(registerValidator.rules(forControl: registerField), "Field should unregister")
    }
    
    // MARK: Init passing delegate by parameter
    
    func testInitDelegate() {
        XCTAssertNotNil(initDelegateValidator.delegate, "Delegate should be not nil")
    }
    
    // MARK: Rules For Control
    
    func testRulesForControl() {
        rulesForControlValdiator.register(control: rulesForControlField, rules: rulesForControlRules)
        
        let array = rulesForControlValdiator.rules(forControl: rulesForControlField)
        
        XCTAssertNotNil(array, "Field should contains rules")
        XCTAssertTrue(array?.count == 3, "Field should contains 3 rules")
        XCTAssertTrue(array?[0] is RequiredRule, "The first rule should be a RequiredRule")
        XCTAssertTrue(array?[1] is EmailRule, "The second rule should be a RequiredRule")
        XCTAssertTrue(array?[2] is MinLengthRule, "The third rule should be a RequiredRule")
    }
    
    // MARK: Protocol Rule
    
    func testProtocolRuleInitCustomMsg() {
        for rule in rulesProtocolRule {
            XCTAssertEqual(rule.errorMsg, "Custom Msg", String(describing: type(of: rule)) + " should have a custom message")
        }
    }
    
    // MARK: Protocol RegexRule
    
    func testProtocolRegexRuleInitCustomRegex() {
        for rule in rulesProtocolRegexRule {
            XCTAssertEqual(rule.regex, "^[a-zA-Z0-9_]*$", String(describing: type(of: rule)) + " should have a custom regex")
        }
    }
    
    // MARK: Protocol LengthRule
    
    func testProtocolLengthRuleInitCustomLenght() {
        for rule in rulesProtocolLengthRule {
            XCTAssertEqual(rule.length, 10, String(describing: type(of: rule)) + " should have a custom length")
        }
    }
    
    // MARK: Required Rule
    
    func testValidRequiredRule() {
        XCTAssertTrue(RequiredRule().validate(validRequiredRuleText), "RequiredRule should be valid")
    }
    
    func testInvalidRequiredRule() {
        XCTAssertFalse(RequiredRule().validate(invalidRequiredRuleText), "RequiredRule should be invalid")
    }
    
    // MARK: FullName Rule
    
    func testValidFullNameRule() {
        XCTAssertTrue(FullNameRule().validate(validFullNameRuleText), "FullNameRule should be valid")
    }
    
    func testInvalidFullNameRule() {
        XCTAssertFalse(FullNameRule().validate(invalidFullNameRuleText), "FullNameRule should be invalid")
    }
    
    // MARK: ProductKey Rule
    
    func testValidProductKeyRule() {
        XCTAssertTrue(ProductKeyRule().validate(validProductKeyRuleText), "ProductKeyRule should be valid")
    }
    
    func testInvalidProductKeyRule() {
        XCTAssertFalse(ProductKeyRule().validate(invalidProductKeyRuleText), "ProductKeyRule should be invalid")
    }
    
    // MARK: Email Rule
    
    func testValidEmailRule() {
        XCTAssertTrue(EmailRule().validate(validEmailRuleText), "EmailRule should be valid")
    }
    
    func testInvalidEmailRule() {
        XCTAssertFalse(EmailRule().validate(invalidEmailRuleText), "EmailRule should be invalid")
    }
    
    // MARK: WeakPassword Rule
    
    func testValidWeakPasswordRule() {
        XCTAssertTrue(WeakPasswordRule().validate(validWeakPassWordRuleText), "WeakPasswordRule should be valid")
    }
    
    func testInvalidWeakPasswordRule() {
        XCTAssertFalse(WeakPasswordRule().validate(invalidWeakPassWordRuleText), "WeakPasswordRule should be invalid")
    }
    
    // MARK: MediumPassword Rule
    
    func testValidMediumPasswordRule() {
        XCTAssertTrue(MediumPasswordRule().validate(validMediumPasswordRuleText), "MediumPasswordRule should be valid")
    }
    
    func testInvalidMediumPasswordRule() {
        XCTAssertFalse(MediumPasswordRule().validate(invalidMediumPasswordRuleText), "MediumPasswordRule should be invalid")
    }
    
    // MARK: StrongPassword Rule
    
    func testValidStrongPasswordRule() {
        XCTAssertTrue(StrongPasswordRule().validate(validStrongPasswordRuleText), "StrongPasswordRule should be valid")
    }
    
    func testInvalidStrongPasswordRule() {
        XCTAssertFalse(StrongPasswordRule().validate(invalidStrongPasswordRuleText), "StrongPasswordRule should be invalid")
    }
    
    // MARK: MaxLength Rule
    
    func testValidMaxLengthRule() {
        XCTAssertTrue(MaxLengthRule(length: 5).validate(validMaxLengthRuleText), "MaxLengthRule should be valid")
    }
    
    func testInvalidMaxLengthRule() {
        XCTAssertFalse(MaxLengthRule(length: 5).validate(invalidMaxLengthRuleText), "MaxLengthRule should be invalid")
    }
    
    // MARK: MinLength Rule
    
    func testValidMinLengthRule() {
        XCTAssertTrue(MinLengthRule(length: 5).validate(validMinLengthRuleText), "MinLengthRule should be valid")
    }
    
    func testInvalidMinLengthRule() {
        XCTAssertFalse(MinLengthRule(length: 5).validate(invalidMinLengthRuleText), "MinLengthRule should be invalid")
    }
    
    // MARK: EqualLength Rule
    
    func testValidEqualLengthRule() {
        XCTAssertTrue(EqualLengthRule(length: 5).validate(validEqualLengthRuleText), "EqualLengthRule should be valid")
    }
    
    func testInvalidEqualLengthMore() {
        XCTAssertFalse(EqualLengthRule(length: 5).validate(invalidEqualLengthRuleTextMore), "MinLengthRule should be invalid (more)")
    }
    
    func testInvalidEqualLengthLess() {
        XCTAssertFalse(EqualLengthRule(length: 5).validate(invalidEqualLengthRuleTextLess), "MinLengthRule should be invalid (less)")
    }
    
    // MARK: Alpha Rule
    
    func testValidAlphaRule() {
        XCTAssertTrue(AlphaRule().validate(validAlphaRuleText), "AlphaRule should be valid")
    }
    
    func testInvalidAlphaRule() {
        XCTAssertFalse(AlphaRule().validate(invalidAlphaRuleText), "AlphaRule should be invalid")
    }
    
    // MARK: AlphaNumeric Rule
    
    func testValidAlphaNumericRule() {
        XCTAssertTrue(AlphaNumericRule().validate(validAlphaNumericRuleText), "AlphaNumericRule should be valid")
    }
    
    func testInvalidAlphaNumericRule() {
        XCTAssertFalse(AlphaNumericRule().validate(invalidAlphaNumericRuleText), "AlphaNumericRule should be invalid")
    }
    
    // MARK: Ipv4 Rule
    
    func testValidIpv4Rule() {
        for adress in validIpv4RuleTexts {
            XCTAssertTrue(Ipv4Rule().validate(adress), "Ipv4Rule should be valid")
        }
    }
    
    func testInvalidIpv4Rule() {
        for adress in invalidIpv4RuleTexts {
            XCTAssertFalse(Ipv4Rule().validate(adress), "Ipv4Rule should be invalid")
        }
    }
    
    // MARK: Confirm Rule
    
    func testValidConfirmRule() {
        XCTAssertTrue(ConfirmRule(confirmField: validConfirmRuleFields.field1)
            .validate(validConfirmRuleFields.field2.text!), "ConfirmRule should be valid")
    }
    
    func testInvalidConfirmRule() {
        XCTAssertTrue(ConfirmRule(confirmField: invalidConfirmRuleFields.field1)
            .validate(validConfirmRuleFields.field2.text!), "ConfirmRule should be invalid")
    }
    
    // MARK: ValidateAllRules
    
    func testValidValidateAllRules() {
        validViewController.fieldName.text = "Bruce"
        validViewController.fieldFullName.text = "Bruce Wayne"
        validViewController.fieldEmail.text = "bruce@we.com"
        validViewController.fieldPasswd.text = "Batman"
        
        validViewController.register()
        validViewController.submitForm()
        
        XCTAssertTrue(validViewController.Validated, "All fields should be valdiated")
    }
    
    func testInvalidValidateAllRules() {
        invalidViewController.fieldName.text = "Bruce"
        invalidViewController.fieldFullName.text = "Bruce Wayne"
        invalidViewController.fieldEmail.text = "bruce@we.com"
        invalidViewController.fieldPasswd.text = ""
        
        invalidViewController.register()
        invalidViewController.submitForm()
        
        XCTAssertFalse(invalidViewController.Validated, "The validation should fail")
    }
}
