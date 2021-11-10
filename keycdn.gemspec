# -*- encoding: utf-8 -*-
require File.expand_path('../lib/keycdn/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name = "keycdn"
  gem.homepage = "https://www.keycdn.com"
  gem.version = KeyCDN::VERSION
  gem.license = "MIT"
  gem.files = `git ls-files`.split($\)
  gem.require_paths = ['lib']
  gem.summary = %Q{A Ruby gem for the KeyCDN API}
  gem.description = %Q{This Ruby gem helps you to interact with the KeyCDN API}
  gem.authors = ["KeyCDN"]
  gem.add_dependency 'json' if RUBY_VERSION.start_with? "1.8"
end
