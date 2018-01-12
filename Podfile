project 'MyMenuReader.xcodeproj'

use_frameworks!

target ‘MyMenuReader’ do
    pod 'TesseractOCRiOS', '4.0.0'
    pod 'Alamofire', '4.5'
    pod 'AlamofireImage', '~> 3.3'
    pod "SwiftyJSON", ">= 2.2"
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['ENABLE_BITCODE'] = 'NO'
    end
  end
end