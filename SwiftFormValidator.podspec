Pod::Spec.new do |s|
  s.name         = "SwiftFormValidator"
  s.version      = "1.0.0"
  s.summary      = "A library to simplify form validation in Siwft"
  s.homepage     = "https://github.com/AndersonSKM/SwiftFormValidator"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
  s.license      = "MIT"
  s.author       = { "Anderson Macedo" => "anderson.krs95@gmail.com" }
  s.platform     = :ios
  s.ios.deployment_target = "8.0"
  s.source       = { :git => "https://github.com/AndersonSKM/SwiftFormValidator.git", :tag => "#{s.version}" }
  s.source_files  = "SwiftFormValidator/**/*.{h,m,swift}"
  s.frameworks = "Foundation", "UIKit"
  s.requires_arc = true
end
