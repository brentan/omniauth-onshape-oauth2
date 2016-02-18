# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth-onshape-oauth2/version'

Gem::Specification.new do |gem|
  gem.name          = "omniauth-onshape-oauth2"
  gem.version       = OmniAuth::OnShapeOAuth2::VERSION
  gem.authors       = ["Brentan Alexander"]
  gem.email         = ["brentan@swiftcalcs.com"]
  gem.summary       = %q{A onShape OAuth2 stategy for OmniAuth.}
  gem.description   = %q{A onShape OAuth2 stategy for OmniAuth.}
  gem.homepage      = "https://www.github.com/brentan/omniauth-onshape-oauth2"
  gem.license       = "MIT"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency 'omniauth', '~> 1.0'
  gem.add_runtime_dependency 'omniauth-oauth2'

  gem.add_development_dependency 'bundler', '~> 1.3'
  gem.add_development_dependency 'rake'

  gem.add_development_dependency 'rspec', '~> 2.14.1'
  gem.add_development_dependency 'simplecov'
end
