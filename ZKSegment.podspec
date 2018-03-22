Pod::Spec.new do |s|
  s.name = 'ZKSegment'
  s.version = '2.0.1'
  s.ios.deployment_target = '8.0'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.summary = '一个分段选择控件。'
  s.homepage = 'https://github.com/WangWenzhuang/ZKSegment'
  s.authors = { 'WangWenzhuang' => '1020304029@qq.com' }
  s.source = { :git => 'https://github.com/WangWenzhuang/ZKSegment.git', :tag => s.version }
  s.source_files = 'ZKSegment/*.swift'
  s.requires_arc = true
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '3.0' }
end
