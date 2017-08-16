Pod::Spec.new do |s|
  s.name         = "XJKAlertView"
  s.version      = "1.0.0"
  s.summary      = "XJKAlertView，弹出框的封装，封装不完美，请多多指教！"
  s.description  = <<-DESC
  这只是一个测试，如果感兴趣请转到 https://github.com/MoreToMost/XJKAlertView
                   DESC

  s.homepage     = "https://github.com/MoreToMost/XJKAlertView"
  s.license      = "MIT"
  s.author             = { "Jack" => "xjk2365549967@163.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/MoreToMost/XJKAlertView.git", :tag => "v1.0.1" }
  s.source_files  = "XJKAlertView/XJKAlertView/*"
  s.requires_arc = true
end
