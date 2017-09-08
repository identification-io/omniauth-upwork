# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth/upwork/version'

Gem::Specification.new do |spec|
  spec.name          = "omniauth-upwork-oauth"
  spec.version       = OmniAuth::Upwork::VERSION
  spec.authors       = ["Eugene Likholetov", "Joel Van Horn"]
  spec.email         = ["bsboris@gmail.com", "joel@joelvanhorn.com"]

  spec.summary       = %q{Upwork strategy for OmniAuth.}
  spec.description   = %q{Upwork strategy for OmniAuth.}
  spec.homepage      = "https://github.com/bsboris/omniauth-upwork"
  spec.license       = "MIT"

  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'omniauth-oauth', '~> 1.0'

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
end
