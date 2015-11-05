Pod::Spec.new do |s|
  s.name          = "TMPModelValidation"
  s.version       = "1.0.5"
  s.summary       = "TMPModelValidation is an Objective-C library that allows to validate data/model/forms easily. Suits for any NSObject."  
  s.homepage      = "http://github.com/plandem/TMPModelValidation"
  s.license       = { :type => 'MIT', :file => 'LICENSE' }
  s.author        = { "Andrey Gayvoronsky" => "plandem@gmail.com" }
  s.source        = { :git => "https://github.com/plandem/TMPModelValidation.git", :tag => s.version.to_s }

  s.framework     = 'Foundation', 'CoreGraphics'
  s.requires_arc  = true
  s.ios.deployment_target = '5.0'
  s.osx.deployment_target = '10.7'
  s.prefix_header_contents = '#define FXMODELVALIDATION_FXFORMS 1'
  s.source_files = 'TMPModelValidation/*.{h,m}', 'TMPModelValidation/validators/*.{h,m}', 'TMPModelValidation/validators/filters/*.{h,m}'
end
