Pod::Spec.new do |s|
  s.name = 'ZKSegment'
  s.version = '5.0'
  s.swift_version = '5.0'
  s.ios.deployment_target = '8.0'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.summary = '一个分段选择控件。'
  s.homepage = 'https://github.com/WangWenzhuang/ZKSegment'
  s.authors = { 'WangWenzhuang' => '1020304029@qq.com' }
  s.source = { :git => 'https://github.com/WangWenzhuang/ZKSegment.git', :tag => s.version }
  s.source_files = 'ZKSegment/*.swift'
  s.requires_arc = true
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '5.0' }
end
