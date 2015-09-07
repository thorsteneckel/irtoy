$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'irtoy/version'

Gem::Specification.new do |s|
  s.name        = 'irtoy'
  s.version     = IRToy::VERSION
  s.date        = '2015-09-07'
  s.summary     = ' A gem for transmitting and receiving infrared signals from an IR Toy'
  s.description = 'Heavily inspiered by https://github.com/crleblanc/PyIrToy and https://github.com/djellemah/irtoy-hexbug-spider .'
  s.authors     = ['Thorsten Eckel']
  s.email       = 'none@rubygems.org'
  s.files       = ['lib/hola.rb']
  s.homepage    = 'https://github.com/thorsteneckel/irtoy'
  s.platform = Gem::Platform::RUBY
  s.licenses = ['GPL-3']

  # files
  s.files         = `git ls-files`.split("\n")
  s.require_paths = ['lib']

  s.add_runtime_dependency 'rubyserial', '~> 0.2.4', '~> 0.2.4'
end
