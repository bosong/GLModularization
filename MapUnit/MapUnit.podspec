Pod::Spec.new do |s|

  s.name         = "MapUnit"
  s.version      = "0.0.1"
  s.summary      = "A short description of MapUnit."
  s.description  = <<-DESC
  MapUnit
                   DESC

  s.homepage     = "http://MapUnit"
  s.license      = "MIT"
  s.author       = { "app" => "app@yooli.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "http://MapUnit.git", :tag => "#{s.version}" }

  s.source_files  = "**/*.{h,m}"
  s.exclude_files = "MapUnit/AppDelegate.{h,m}", "MapUnit/main.m"

  # s.public_header_files = "Classes/**/*.h"

  # s.resource  = "icon.png"
  s.resources = "MapUnit/images/*.png"
  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  s.dependency "SDWebImage", "~> 3.7.3"

end
