# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mailsocio_rails/version'

Gem::Specification.new do |spec|
  spec.name          = "mailsocio_rails"
  spec.version       = MailsocioRails::VERSION
  spec.authors       = ["Anahoret team"]
  spec.email         = ["dmitriy.kiriyenko@anahoret.com"]
  spec.summary       = %q{ActionMailer plugin to use mailsocio to deliver emails}
  spec.description   = File.read(File.expand_path(File.join(File.dirname(__FILE__), 'README.md')))
  spec.homepage      = "app.mailarbor.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'action_mailer', '>=3.2', '<5'

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
