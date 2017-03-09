Pod::Spec.new do |s|

  s.name         = "XCCircleProgressView"
  s.version      = "1.0.0"
  s.summary      = "CircleProgressView"

  s.description  = "CircleProgressView自定义圆形进度圈"

  s.homepage     = "https://github.com/fanxiaocong/XCCircleProgressView"

  s.license      = "MIT"


  s.author       = { "樊小聪" => "1016697223@qq.com" }


  s.source       = { :git => "https://github.com/fanxiaocong/XCCircleProgressView.git", :tag => s.version }


  s.source_files = "XCCircleProgressView"
  s.requires_arc = true
  s.platform     = :ios, "8.0"
  s.frameworks   =  'UIKit'

end

