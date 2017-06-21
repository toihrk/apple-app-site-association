# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'apple/app/site/association'

require 'rspec'
require 'rack/test'

ENV['RACK_ENV'] = 'test'

module RSpecMixin
  include Rack::Test::Methods
  def app
    Apple::App::Site::Association
  end
end

RSpec.configure do |c|
  c.include RSpecMixin
end
