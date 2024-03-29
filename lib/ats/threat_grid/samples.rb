module ATS
  module ThreatGrid
    class Samples
      attr_reader :api

      def initialize(api)
        @api = api
      end

      def search(term)
        api.get("samples/search", params: { checksum: term })
      end
    end
  end
end
