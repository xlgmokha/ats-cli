require 'json'
require 'logger'
require 'net/http'
require 'yaml'

require 'ats/configuration'
require 'ats/http_api'
require 'ats/threat_grid/api'
require 'ats/threat_grid/organizations'
require 'ats/threat_grid/users'
require 'ats/version'

module ATS
  class << self
    def logger
      configuration.logger
    end

    def configure
      yield configuration
    end

    def configuration
      @configuration ||= Configuration.new
    end
  end
end