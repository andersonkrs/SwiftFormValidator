//
//  ViewController.swift
//  Example
//
//  Created by Anderson Macedo on 26/03/17.
//  Copyright © 2017 AndersonSKM. All rights reserved.
//

import UIKit
import SwiftFormValidator

class ViewController: UITableViewController, ValidatorDelegate {

    @IBOutlet weak var lbUserName: UILabel!
    @IBOutlet weak var lbFullName: UILabel!
    @IBOutlet weak var lbEmail: UILabel!
    @IBOutlet weak var lbProductKey: UILabel!
    @IBOutlet weak var lbPassword: UILabel!
    @IBOutlet weak var lbConfirm: UILabel!
    
    @IBOutlet weak var pgPassword: UIProgressView!
    
    @IBOutlet weak var edUserName: UITextField!
    @IBOutlet weak var edFullName: UITextField!
    @IBOutlet weak var edEmail: UITextField!
    @IBOutlet weak var edProductkey: UITextField!
    @IBOutlet weak var edPassword: UITextField!
    @IBOutlet weak var edConfirm: UITextField!
    
    let validator = Validator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        validator.delegate = self
        
        validator.register(control: edUserName, label: lbUserName, rules: [RequiredRule(), AlphaNumericRule()])
        
        validator.register(control: edFullName, label: lbFullName, rules: [RequiredRule(), FullNameRule()])
        
        validator.register(control: edEmail, label: lbEmail, rules: [RequiredRule(), EmailRule()])
        
        validator.register(control: edPassword, label: lbPassword, rules: [RequiredRule(), WeakPasswordRule(message: "Weak"),MediumPasswordRule(message: "Medium"), StrongPasswordRule(message: "Strong")])
        
        validator.register(control: edConfirm, label: lbConfirm, rules: [RequiredRule(), ConfirmRule(confirmField: edPassword)])
        
        validator.register(control: edProductkey, label: lbProductKey, rules: [RequiredRule(), ProductKeyRule()])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submmit() -> Void {
        validator.validateAll()
    }
    
    @IBAction func passwordChange(_ sender: UITextField) {
     
        let result = validator.validate(control: edPassword)
        
        if (result.rule is RequiredRule) {
            
            result.label?.text = "This Field Is Required"
            result.label?.textColor = UIColor.red
            pgPassword.progress = 0.01
            
        } else if (result.rule is WeakPasswordRule) {
            
            result.label?.text = "Weak"
            result.label?.textColor = UIColor.red
            pgPassword.progress = 0.25
            
        } else if  (result.rule is MediumPasswordRule) {
            
            result.label?.text = "Medium"
            result.label?.textColor = UIColor.orange
            pgPassword.progress = 0.5
            
        } else if result.rule is StrongPasswordRule {
            
            result.label?.text = "Good"
            result.label?.textColor = UIColor(red:0.91, green:0.90, blue:0.34, alpha:1.0)
            pgPassword.progress = 0.75
            
        } else {
            
            result.label?.text = "Strong"
            result.label?.textColor = UIColor.green
            pgPassword.progress = 1
            
        }
        
        pgPassword.progressTintColor = result.label?.textColor
        result.label?.isHidden = false
    }
 
    // MARK: - ValidatorDelegate
    
    func validationSucess() -> Void {
        let alert = UIAlertController(title: "Validation Sucess", message: "Your form has been validated", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func validation(sucess: Bool, validations: [ValidationResult]) -> Bool {
        
        for validation in validations {
            
            validation.label?.textColor = UIColor.red
            
            if (validation.rule == nil) {
                validation.label?.isHidden = true
                validation.control.layer.borderColor = UIColor.black.cgColor
            } else {
                validation.label?.isHidden = false
                validation.label?.text = validation.rule?.errorMsg
                validation.control.layer.borderColor = UIColor.red.cgColor
            }
            
        }
        
        // Do extra validations here
        if sucess {
            // if not somevalidation return false
        }
        
        return sucess
    }
    
}

