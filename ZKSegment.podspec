Pod::Spec.new do |s|
	s.name = "ZKSegment"
	s.version = "1.0.3"
	s.summary = "ZKSegment is segment view."
	s.homepage = "https://github.com/WangWenzhuang/ZKSegment"
	s.license = 'MIT'
	s.author = { "WangWenzhuang" => "1020304029@qq.com" }
	s.platform = :ios, '7.0'
	s.source = { :git => "https://github.com/WangWenzhuang/ZKSegment.git", :tag => "v1.0.3" }
	s.source_files = 'ZKSegment/*'
	s.requires_arc = true
end