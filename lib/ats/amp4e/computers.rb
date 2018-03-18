module ATS
  module AMP4E
    class Computers
      attr_reader :api

      def initialize(api)
        @api = api
      end

      def list
        api.get("computers")
      end

      def show(id)
        api.get("computers/#{id}")
      end

      def trajectory(id)
        api.get("computers/#{id}/trajectory")
      end

      def user_activity(query)
        api.get("computers/user_activity", params: { q: query })
      end
    end
  end
end
