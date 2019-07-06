
Pod::Spec.new do |s|

    s.name         = "ELKUtilKit-Chained"

    s.version      = "0.0.1"

    s.summary      = "Chained Util Kit"

    s.description  = <<-DESC
                        Some useful tools
                    DESC

    s.homepage     = "https://github.com/CircusJonathan/ELKUtilKit"

    s.license      = "MIT"
    s.author             = { "Jonathan" => "Jonathan_dk@163.com" }

    s.platform     = :ios

    s.source       = { :git => "https://github.com/CircusJonathan/ELKUtilKit.git", :tag => "#{s.version}" }

    s.requires_arc = true


    s.vendored_frameworks = "ELKKit/ELKUtilKit-Chained.framework"

    s.ios.frameworks      = 'Foundation', 'UIKit'

    s.dependency 'SDWebImage'
    s.dependency 'ELKUtilKit'





end
