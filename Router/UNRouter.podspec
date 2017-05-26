Pod::Spec.new do |s|

  s.name         = "UNRouter"
  s.version      = "0.0.1"
  s.summary      = "A short description of UNRouter."

  s.description  = <<-DESC
  UNRouter
                   DESC

  s.homepage     = "http://UNRouter"
  s.license      = "MIT"
  s.author       = { "app" => "app@yooli.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "http://UNRouter.git", :tag => "#{s.version}" }

  s.source_files  = "**/*.{h,m}"
  s.requires_arc = true

end
