# frozen_string_literal: true

module UniversalLink
  class InstallGenerator < ::Rails::Generators::Base
    source_root File.expand_path '../../templates', __FILE__

    desc 'Install Apple::App::Site::Association'
    def install
      template 'initializer.rb', 'config/initializers/apple-app-site-association.rb'
    end
  end
end
