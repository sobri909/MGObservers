Pod::Spec.new do |s|
  s.name         = "MGObservers"
  s.version      = "1.0.0"
  s.summary      = "Blocks based keypath and UIControlEvents observers"
  s.homepage     = "https://github.com/sobri909/MGObservers"
  s.license      = { :type => "BSD", :file => "LICENSE" }
  s.author       = { "Matt Greenfield" => "matt@bigpaua.com" }
  s.source       = { :git => "https://github.com/sobri909/MGObservers.git", :tag => "1.0.0" }
  s.requires_arc = true
  s.watchos.deployment_target = '2.0'
  s.ios.deployment_target = '6.0'
  s.source_files = 'MGObservers/*.{h,m}'
end
