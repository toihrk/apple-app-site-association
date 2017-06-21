# frozen_string_literal: true

require 'json'
require 'sinatra/base'

module Apple
  module App
    module Site
      class Association < Sinatra::Base
        class Config
          def initialize
            @apps = []
            @details = []
          end

          def apps(*a)
            @apps.push(*a)
          end

          def details(*d)
            @details.push(*d)
          end

          def to_json
            {
              apps: @apps,
              details: @details
            }.to_json
          end
        end

        def self.config
          @config ||= Config.new
        end

        def self.configure
          yield(config) if block_given?
        end

        get '/apple-app-site-association' do
          content_type :json
          self.class.config.to_json
        end
      end
    end
  end
end
