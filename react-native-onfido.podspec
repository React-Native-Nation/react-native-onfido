require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "react-native-onfido"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.description  = <<-DESC
                  react-native-onfido
                   DESC
  s.homepage     = "https://github.com/React-Native-Nation/react-native-onfido"
  s.license      = "MIT"
  # s.license    = { :type => "MIT", :file => "FILE_LICENSE" }
  s.authors      = { "Your Name" => "jamesjara@gmail.com" }
  s.platforms    = { :ios => "10.0" }
  s.swift_version = '4.2'
  s.source       = { :git => "https://github.com/React-Native-Nation/react-native-onfido.git", :tag => "#{s.version}" }

  s.source_files = "ios/**/*.{h,m,swift}"
  s.requires_arc = true

  s.dependency "React"
  s.dependency "Onfido", "~> 15.0.0"
end
 
