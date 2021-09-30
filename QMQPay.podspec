#
# Be sure to run `pod lib lint QMQPay.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'QMQPay'
  s.version          = '0.1.0'
  s.summary          = 'A short description of QMQPay.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/HussamElsadany/QMQPay'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'hussam.elsadany@gmail.com' => 'Hussam Elsadany' }
  s.source           = { :git => 'https://github.com/HussamElsadany/QMQPay.git', :tag => s.version.to_s }

  s.ios.deployment_target = '12.1'

  s.source_files = 'QMQPay/Classes/**/*'
  
  # s.resource_bundles = {
  #   'QMQPay' => ['QMQPay/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
   s.dependency 'RMQClient', '~> 0.11.0'
end
