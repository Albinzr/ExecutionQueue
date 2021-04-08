Pod::Spec.new do |s|
  s.name         = "ExecutionQueue"
  s.version      = "1.0.3"
  s.summary      = "A light weight queueing library for serial execution with retry"
  s.homepage     = "https://github.com/Albinzr/ExecutionQueue.git"
  s.license      = 'MIT'
  s.author       = { "Albin CR" => "albin.git@gmail.com" }
  s.source       = { :git => "https://github.com/Albinzr/ExecutionQueue.git", :tag => "#{s.version}" }
  s.swift_version = "4.1"
  s.requires_arc = true
  s.platform     = :ios, '10.0'

  s.source_files  = "ExecutionQueue", "ExecutionQueue/*.swift"
  
end
