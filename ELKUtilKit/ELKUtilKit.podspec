
Pod::Spec.new do |spec|

    spec.name         = "ELKUtilKit"
    
    spec.version      = '1.2.9'
   
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
    
    spec.public_header_files = 'ELKUtilKit/ELKUtilKit.h'
    spec.source_files        = 'ELKUtilKit/ELKUtilKit.{h,m}'

    spec.ios.frameworks      = 'Foundation', 'UIKit', 'SystemConfiguration'
    spec.libraries   = 'c++', 'z'
    
    
    spec.subspec 'ELKUtils' do |ets|
        ets.source_files = 'ELKUtilKit/Utils/**/*.{h,m}'
        ets.public_header_files = 'ELKUtilKit/Utils/**/*.h'
        
        ets.ios.frameworks = 'Foundation', 'UIKit', 'SystemConfiguration'
        ets.libraries   = 'c++', 'z'
    end
    
    spec.subspec 'ELKUtilResources' do |res|
        res.resources   = 'ELKUtilKit/Resources/*.bundle'
    end
    
    spec.subspec 'ELKModules' do |ems|
        ems.source_files = 'ELKUtilKit/Modules/**/*.{h,m}'
        ems.public_header_files = 'ELKUtilKit/Modules/**/*.h'
        
        ems.dependency 'ELKUtilKit/ELKUtils'
        ems.dependency 'ELKUtilKit/ELKUtilResources'
        
        ems.ios.frameworks = 'Foundation', 'UIKit', 'SystemConfiguration'
        ems.libraries   = 'c++', 'z'
    end


end
