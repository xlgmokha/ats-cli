module ATS
  module ThreatGrid
    class API
      HEADERS = {
        'Content-Type' => 'application/json',
        'User-Agent' => "RubyGems/ATS #{ATS::VERSION}",
      }.freeze

      attr_reader :http, :port, :host, :scheme, :api_key

      def initialize(configuration:, debug: false)
        @http = Net::Hippie::Client.new(headers: HEADERS, verify_mode: debug ? OpenSSL::SSL::VERIFY_NONE : nil)
        @configuration = configuration
        @port = configuration[:port]
        @scheme = configuration[:scheme]
        @host = configuration[:host]
        @api_key = configuration[:api_key]
      end

      def whoami
        get("session/whoami")
      end

      def users
        ATS::ThreatGrid::Users.new(self)
      end

      def organizations
        ATS::ThreatGrid::Organizations.new(self)
      end

      def samples
        ATS::ThreatGrid::Samples.new(self)
      end

      def search
        ATS::ThreatGrid::Search.new(self)
      end

      def get(url, params: {}, version: 3)
        http.get(build_uri(url, version: version), body: default_payload.merge(params)) do |request, response|
          JSON.parse(response.body, symbolize_names: true)[:data]
        end
      end

      private

      def default_payload
        { api_key: api_key }
      end

      def build_uri(relative_url, version:)
        URI::Generic.build(host: host, port: port, scheme: scheme, path: "/api/v#{version}/#{relative_url}")
      end
    end
  end
end
