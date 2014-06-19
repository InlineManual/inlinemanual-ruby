# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'inline_manual/version'

Gem::Specification.new do |spec|
  spec.name          = 'inlinemanual'
  spec.version       = InlineManual::VERSION
  spec.authors       = ['Vojtěch Kusý']
  spec.email         = ['vojta@inlinemanual.com']
  spec.description   = 'Inline Manual is an easy way to create interactive manuals for your web applications.'
  spec.summary       = 'Ruby gem for Inline Manual'
  spec.homepage      = 'https://inlinemanual.com'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'minitest', '>= 5.0'
  spec.add_development_dependency 'rake'
end
