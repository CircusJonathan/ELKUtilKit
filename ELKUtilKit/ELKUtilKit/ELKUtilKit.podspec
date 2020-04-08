
Pod::Spec.new do |spec|

    spec.name         = "ELKUtilKit"
    
    spec.version      = '1.2.6'
   
    spec.summary      = 'Util'
    spec.description  = <<-DESC
                     Some useful tools
                     DESC
    spec.homepage     = 'https://github.com/elkshrek/ELKUtilKit'
    spec.license      = 'MIT'
    spec.author       = { 'Jonathan' => 'Jonathan_dk@163.com' }
    spec.platform     = :ios
    spec.source       = { :git => "https://github.com/elkshrek/ELKUtilKit.git", :tag => "#{spec.version}" }
    spec.requires_arc = true
    
    
    spec.subspec 'ELKUtils' do |utp|
       utp.source_files = 'ELKUtilKit/Utils/**/*.{h,m}'
       utp.public_header_files = 'ELKUtilKit/Utils/**/*.h'
       
       utp.ios.frameworks = 'Foundation', 'UIKit', 'SystemConfiguration'
       utp.libraries   = 'c++', 'z'
    end
    
    

#    spec.public_header_files = 'ELKUtilKit/Modules/**/*.h', 'ELKUtilKit/ELKUtilKit.h'
#    spec.source_files        = 'ELKUtilKit/Modules/**/*.{h,m}', 'ELKUtilKit/ELKUtilKit.h'
#    spec.resources           = 'ELKUtilKit/Resources/*.bundle'

    spec.ios.frameworks      = 'Foundation', 'UIKit', 'SystemConfiguration'
    spec.libraries   = 'c++', 'z'


end
