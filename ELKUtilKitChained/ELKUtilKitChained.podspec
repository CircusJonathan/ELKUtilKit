Pod::Spec.new do |s|

    s.name         = "ELKUtilKitChained"

    s.version      = "1.1.8"

    s.summary      = "Chained Util Kit"

    s.description  = <<-DESC
                        Some useful tools
                    DESC

    s.homepage     = "https://gitee.com/elkshrek/ELKUtilKit"

    s.license      = "MIT"
    s.author             = { "Jonathan" => "Jonathan_dk@163.com" }

    s.platform     = :ios

    s.source       = { :git => "https://gitee.com/elkshrek/ELKUtilKit.git", :tag => "#{s.version}" }
    
    s.requires_arc = true
    
    
    s.public_header_files = 'ELKUtilKitChained/ELKUtilKitChained.h'
    s.source_files        = 'ELKUtilKitChained/**/*.{h,m}'
    
    s.ios.frameworks      = 'Foundation', 'UIKit'
    
    s.dependency 'SDWebImage'
    s.dependency 'ELKUtilKit'
    
    
    
end
