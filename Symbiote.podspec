Pod::Spec.new do |s|
  s.name             = "Symbiote"
  s.version          = "0.2.0"
  s.summary          = "Symbiote is an analytics framework that supports multiple platforms, auto enables analytics in an app (through swizzling) and is easily extensible."

  s.description      = <<-DESC
Symbiote is an analytics framework that supports multiple platforms, auto enables basic analytics in your app and is easily extensible with event processors.
Extended analytics support can be enabled by subclassing UIButtons and UIViewControllers from analytics subclasses and providing a view name. This will enable the framework to automatically build view paths and label buttons with their respective actions correctly.
Unsupported analytics platforms may be integrated by implementing a simple event logging protocol. Custom events can be created easily.
Events may be filtered and processed (add/edit/remove/analyze data) by adding custom event processors to the event bus.
                        DESC

  s.homepage         = "https://github.com/vectorform/Symbiote"
  s.license          = 'BSD' #{:type => "BSD", :file => "LICENSE"}
  s.author           = { "Vectorform" => "jstart@vectorform.de" }
  s.source           = { :git => "https://github.com/vectorform/Symbiote.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/vectorform'

  s.source_files = 'Core/'
  s.platform     = :ios, '8.0'
  s.requires_arc = true
  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.default_subspec = 'Core', 'Provider/DebugLog'

  s.subspec 'Core' do |core|
    core.source_files = 'Core/**/*.swift'
  end
  s.subspec 'Provider' do |p|
    p.subspec 'DebugLog' do |debuglog|
      debuglog.dependency "Symbiote/Core"
      debuglog.source_files = 'Provider/DebugLog/*.swift'
    end
    p.subspec 'AWSMobileAnalytics' do |aws|
      aws.dependency "Symbiote/Core"
      aws.dependency "AWSMobileAnalytics", "~> 2.3.2"
      aws.source_files = 'Provider/AWSMobileAnalytics/*.swift'
    end
    p.subspec 'FlurryAnalytics' do |flurry|
      flurry.dependency "Symbiote/Core"
      flurry.dependency "Flurry-iOS-SDK/FlurrySDK"
      flurry.source_files = 'Provider/FlurryAnalytics/*.swift'
    end
  end
end
