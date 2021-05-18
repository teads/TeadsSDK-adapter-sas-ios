Pod::Spec.new do |s|

    s.name                      = 'TeadsSASAdapter'
    s.version                   = '4.8.7'
    s.summary                   = "SAS Adapter for Teads' iOS SDK"
    s.module_name               = 'TeadsSASAdapter'
    s.description               = <<-DESC
                                Use this adapter to include Teads as a demand source in your mediation waterfall
                                DESC
    s.homepage                  = 'https://github.com/teads/TeadsSDK-adapter-sas-ios'
    s.documentation_url         = 'https://support.teads.tv/support/solutions/articles/36000256729-smart-ad-mediation-ios'
    s.license                   = { :type => 'Copyright', :text => 'Copyright Teads 2021' }
    s.authors                   = { 'Teads' => 'support-sdk@teads.tv'}

    s.source                    = { :git => 'https://github.com/teads/TeadsSDK-adapter-sas-ios.git', :tag => "v#{s.version}"}
    s.platform                  = 'ios'
    s.ios.deployment_target     = '9.0'
    s.static_framework          = true
    s.requires_arc              = true
    s.source_files              = 'TeadsSASAdapter/**/*{.swift}'
    s.swift_versions            = ['4.3', '5.0', '5.1']

    s.dependency                'TeadsSDK', s.version.to_s
    s.dependency                'Smart-Display-SDK', '>= 7.6.2'

end
