require "rails/generators"
module Notifications
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Create Notifications's base files"
      source_root File.expand_path("../../..", __dir__)

      def add_initializer
        path = "#{Rails.root}/config/initializers/notifications.rb"
        if File.exist?(path)
          puts "Skipping config/initializers/notifications.rb creation, as file already exists!"
        else
          puts "Adding Notifications initializer (config/initializers/notifications.rb)..."
          template "config/initializers/notifications.rb", path
        end
      end

      def add_routes
        route 'mount Notifications::Engine => "/notifications"'
      end
    end
  end
end
