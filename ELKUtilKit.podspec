
Pod::Spec.new do |s|

    s.name         = "ELKUtilKit"

    s.version      = "1.0.5"

    s.summary      = "Util"

    s.description  = <<-DESC
                        Some useful tools
                    DESC

    s.homepage     = "https://github.com/CircusJonathan/ELKUtilKit"

    s.license      = "MIT"
    s.author             = { "Jonathan" => "Jonathan_dk@163.com" }

    s.platform     = :ios

    s.source       = { :git => "https://github.com/CircusJonathan/ELKUtilKit.git", :tag => "#{s.version}" }

    #s.source_files  = "ELKUtilKit", "ELKUtilKit/**/*"

    s.requires_arc = true


    s.vendored_frameworks = 'ELKUtilKit/ELKUtilKit.framework'
    s.preserve_paths = "ELKUtilKit/ELKUtilResources"

    s.ios.frameworks = 'Foundation', 'UIKit'

    s.dependency 'SDWebImage'





end
