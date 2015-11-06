Pod::Spec.new do |spec|
  spec.name         = 'ZKSegment'
  spec.version      = '1.0'
  spec.license      = 'MIT'
  spec.summary      = 'ZKSegment 是一个分段选择控件'
  spec.homepage     = 'https://github.com/WangWenzhuang/ZKSegment'
  spec.author       = '王文壮'
  spec.source       = { :git => 'https://github.com/WangWenzhuang/ZKSegment.git', :tag => 'v1.0' }
  spec.source_files = 'ZKSegment/*'
  spec.requires_arc = true
end