# -*- encoding: utf-8 -*-
require File.expand_path('../lib/muxie/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Joshua Clayton']
  gem.email         = ['jclayton@thoughtbot.com']
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ''

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = 'muxie'
  gem.require_paths = ['lib']
  gem.version       = Muxie::VERSION

  gem.add_dependency 'active_support', '~> 3.0'
  gem.add_dependency 'basic_decorator'

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'simplecov'
end
