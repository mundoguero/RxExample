platform :ios, '13.0'
use_frameworks!

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '5.0'
    end
  end
end


target 'RxExample' do
  use_frameworks!

pod 'RxSwift'
pod 'RxCocoa'

end