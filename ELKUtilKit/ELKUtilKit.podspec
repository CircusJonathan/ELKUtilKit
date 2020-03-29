
Pod::Spec.new do |spec|

    spec.name         = "ELKUtilKit"

    spec.version      = "1.2.1"
    
    spec.summary      = "Util"
    spec.description  = <<-DESC
                      Some useful tools
                      DESC
    spec.homepage     = "https://github.com/elkshrek/ELKUtilKit"
    spec.license      = "MIT"
    spec.author       = { "Jonathan" => "Jonathan_dk@163.com" }
    spec.platform     = :ios
    spec.source       = { :git => "https://github.com/elkshrek/ELKUtilKit.git", :tag => "#{spec.version}" }
    spec.requires_arc = true
    
   # spec.public_header_files = 'ELKUtilKit/ELKUtilKit.h'
    spec.source_files        = 'ELKUtilKit/**/*.{h,m}'
    spec.resources           = 'ELKUtilKit/ELKUtilResources.bundle'

    spec.ios.frameworks      = 'Foundation', 'UIKit'

    spec.dependency 'SDWebImage', '~> 5.6.1'
    

end
