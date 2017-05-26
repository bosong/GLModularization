Pod::Spec.new do |s|

  s.name         = "ChatUnit"
  s.version      = "0.0.1"
  s.summary      = "A short description of ChatUnit."
  s.description  = <<-DESC
  ChatUnit
                   DESC

  s.homepage     = "http://ChatUnit"
  s.license      = "MIT"
  s.author       = { "app" => "app@yooli.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "http://ChatUnit.git", :tag => "#{s.version}" }

  s.source_files  = "**/*.{h,m}"
  s.exclude_files = "ChatUnit/AppDelegate.{h,m}", "ChatUnit/main.m"

  # s.public_header_files = "Classes/**/*.h"

  # s.resource  = "icon.png"
  # s.resources = "ChatUnit/images/*.png"
  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "SDWebImage", "~> 3.7.3"

end
