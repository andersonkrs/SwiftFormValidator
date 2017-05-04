# SwiftFormValidator
>A library to simplify form validation in Swift. 

[![Build Status](https://travis-ci.org/AndersonSKM/SwiftFormValidator.svg?branch=master)](https://travis-ci.org/AndersonSKM/SwiftFormValidator)
![Swift Version](https://img.shields.io/badge/swift-3.0-orange.svg)
![Plataform](https://img.shields.io/badge/plataform-ios-lightgray.svg)
![Pods](https://img.shields.io/badge/pod-v1.2.1-blue.svg)
![License](https://img.shields.io/badge/license-MIT-FF69B4.svg)

![Swift Form Validator](/assets/example.gif)

## Installation

#### CocoaPods
You can use [CocoaPods](http://cocoapods.org/) to install `SwiftFormValidator` by adding it to your `Podfile`:

```ruby
use_frameworks!
pod 'SwiftFormValidator', :git => 'https://github.com/AndersonSKM/SwiftFormValidator'
```
And install:

```
pod install
```
#### Manually
1. Drag and drop ```SwiftFormValidator.swift``` and all rules files in your project.  
2. That's it!

## Usage

Import the library.

```swift
import SwiftFormValidator
```

You have to instantiate a Validator object and set the delegate property to your View Controller class or another.

```swift
let validator = Validator()
```

Now, you can register your fields to validate.

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    
    validator.delegate = self

    //The rules are validated in sequence
    //You can pass a custom length in constructor for rules of type LengthRules
    validator.register(control: edUserName, label: lbUserName, rules: [RequiredRule(), AlphaNumericRule(), MinLengthRule(length: 5)])
    validator.register(control: edFullName, label: lbFullName, rules: [RequiredRule(), FullNameRule()])
    validator.register(control: edEmail, label: lbEmail, rules: [RequiredRule(), EmailRule()])

    //You can pass a custom error message in all rules
    validator.register(control: edPassword, label: lbPassword, rules: [RequiredRule(), StrongPasswordRule(message: "Strong")])

    //You can pass a custom regex in constructor for rules of type RegexRules
    validator.register(control: edConfirm, label: lbConfirm, rules: [RequiredRule(), ConfirmRule(confirmField: edPassword)])
    validator.register(control: edProductkey, label: lbProductKey, rules: [RequiredRule(), ProductKeyRule()])
}
```
The parameter ```label``` is ```Optional```.

You can unregister a field if you need.
```swift
validator.unregister(control: someField)
```
To validate all fields just call the ```validateAll``` method.
```swift
@IBAction func someButtonTaped() -> Void {
    validator.validateAll()
}
```

Implement the ValidatorDelegate protocol.
```swift
func validationSucess() -> Void {
   // All right here
}

func validation(sucess: Bool, validations: [ValidationResult]) -> Bool {
    // The success parameter informs whether all rules have been validated or not

    for validation in validations {
        if (validation.rule == nil) {
            validation.label?.isHidden = true
        } else {
            validation.label?.isHidden = false
            validation.label?.text = validation.rule?.errorMsg
        }
    }

    // Do extra validations here
    if sucess {
        // If the extra validations do not pass, just return false to abort
    }

    return sucess
}
```
The parameter ```validations``` is a list containing all the validations made.
The class ```ValidationResult``` contains the field + label (if you informed) and the rule that has not been validated.
If the property ```Rule``` is equal to ```nil``` the validation has passed. 
When the ```validation``` method returns ```false```, the ```validationSucess``` method is not called.

#### Single Field
```swift
@IBAction func passwordChanged(_ sender: UITextField) {
    if validator.validate(control: edPassword).rule == nil {
        // All right here
    } else {
        // Something is wrong
    }
}
```
#### Custom Validation
To create a custom validation, you just need create a new  ```Rule``` class and contract the protocol ```Rule``` or other inherited from him.
```swift
class BrazilianZipCode: RegexRule {
    var errorMsg: String? = "Invalid Zip Code"
    var regex: String = "\\d{5}-\\d{3}"
    
    required public init() {}
}
```
#### Internationalization
All rules have a constructor with parameter ```message```, in which you can pass a localized error message.
```swift
let myLocalizedText = NSLocalizedString("SomeTranslatedText", comment: "Comment")
validator.register(control: someField, label: someLabel, rules: [RequiredRule(message: myLocalizedText)])
```

## Contribute
Contributions are welcomed!

### Thank you 🎉

If you like this project please leave a star 🌟 here on Github and share it.

## Author
[anderson.krs95@gmail.com]() 

## License

Distributed under the MIT license. See ``LICENSE`` for more information.



