# coding: utf-8
# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.name        = 'apple-app-site-association'
  s.version     = '0.1.1'
  s.authors     = ['toihrk']
  s.email       = ['toihrk@me.com']

  s.summary     = 'A mountable Sinatra application for introduce the universal link to your application'
  s.description = s.summary
  s.homepage    = 'https://github.com/toihrk/apple-app-site-accosiation'
  s.license     = 'MIT'

  raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.' unless s.respond_to?(:metadata)

  s.files = `git ls-files -z`.split(?\x0).reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  s.require_paths = ['lib']

  s.add_development_dependency 'bundler', '~> 1.14'
  s.add_development_dependency 'rake', '~> 12'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'rspec', '~> 3.6'
  s.add_development_dependency 'rack-test'
  s.add_dependency 'sinatra', '~> 2'
end
