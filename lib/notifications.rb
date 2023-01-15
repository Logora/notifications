require "notifications/engine"
require "notifications/configuration"
require "notifications/version"

module Notifications
  class << self
    def config
      return @config if defined?(@config)
      @config = Configuration.new
      @config.user_class               = "User"
      @config.current_user_method      = "current_user"
      @config.authenticate_user_method = nil
      @config
    end

    def configure(&block)
      config.instance_exec(&block)
    end
  end
end
