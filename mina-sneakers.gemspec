# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mina/sneakers/version'

Gem::Specification.new do |spec|
  spec.name          = 'mina-sneakers'
  spec.version       = Mina::Sneakers::VERSION
  spec.authors       = ['Vladimir Sharshov']
  spec.email         = ['vsharshov@gmail.com']
  spec.description   = 'Sneakers tasks for Mina'
  spec.summary       = 'Sneakers tasks for Mina'
  spec.homepage      = 'https://github.com/warpc/mina-sneakers'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'mina', '~> 1.0'
  spec.add_dependency 'sneakers', '~> 2.6'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
end
