# -*- encoding: utf-8 -*-
require File.expand_path('../lib/tourets/rails/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jeremy Woertink", "Justin Mitchell"]
  gem.email         = ["jeremywoertink@gmail.com", "jmitchell4140@gmail.com"]
  gem.description   = "TouRETS is a rails gem used to interface with multiple RETS using the ruby-rets gem"
  gem.summary       = "Use RETS with a LOT less hassle"
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "tourets"
  gem.require_paths = ["lib"]
  gem.version       = TouRETS::Rails::VERSION

  # removed dependency cause rubygems no longer carries this gem.  Moved to :github => 'agentformula/ruby-rets'
  #gem.add_dependency('ruby-rets', :github => 'agentformula/ruby-rets')
  gem.add_dependency('railties', '>= 3.1')
  gem.add_development_dependency('rspec')
  gem.add_development_dependency('vcr')
  gem.add_development_dependency('webmock')
  gem.add_development_dependency('pry')
  gem.add_development_dependency('rails', '>= 3.1')
end
