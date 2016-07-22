module ConverseWithMe
  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  def self.reset
    @configuration = Configuration.new
  end

  class Configuration
    attr_accessor :xmpp_server, :xmpp_server_port, :use_https

    def initialize
      # set default values
      @xmpp_server = 'localhost'
      @xmpp_server_port = '5280'
      @use_https = false
    end
  end
end