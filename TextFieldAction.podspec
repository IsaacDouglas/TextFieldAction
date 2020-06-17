Pod::Spec.new do |s|
  s.name             = 'TextFieldAction'
  s.version          = '0.4.0'
  s.summary          = 'Format text entry in UITextField easily.'
  s.description      = 'Format text entry in UITextField easily.'
  s.homepage         = 'https://github.com/IsaacDouglas/TextFieldAction'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'IsaacDouglas' => 'isaacdouglas2015@gmail.com' }
  s.source           = { :git => 'https://github.com/IsaacDouglas/TextFieldAction.git', :tag => s.version.to_s }
  
  s.ios.deployment_target = '8.0'
  s.source_files = 'TextFieldAction/Classes/**/*'
end
