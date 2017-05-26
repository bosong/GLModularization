platform :ios, '8.0'

workspace 'UnitsDemo.xcworkspace'

def podunits
	pod 'Masonry', '~>1.0.1'
	pod 'YYModel', '~>1.0.3'
    pod 'UNRouter', :path => 'Router'
end

target 'UnitsDemo' do
	project 'UnitsDemo'
    pod 'MapUnit', :path => 'MapUnit'
    pod 'ChatUnit', :path => 'ChatUnit'
	podunits
end


target 'MapUnit' do
    project 'MapUnit/MapUnit'
    pod 'SDWebImage', '~>3.7.3'
    podunits
end


target 'ChatUnit' do
    project 'ChatUnit/ChatUnit'
    podunits
end
