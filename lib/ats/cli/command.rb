module ATS
  module CLI
    class Command < Thor
      class_option :profile, default: :default, required: false
      class_option :debug, default: false, required: false

      def self.printable_commands(*args)
        super.map do |x|
          x[0] = x[0].gsub(/^ats/, "ats #{service_name.downcase}")
          x
        end
      end

      protected

      def api
        self.class.constant_name.new(
          configuration: configuration.fetch(profile)[self.class.service_name.downcase.to_sym],
          debug: configuration.debug,
        )
      end

      def print_json(json)
        say JSON.pretty_generate(json), :green
      end

      def configuration
        ATS.configure do |x|
          Net::Hippie.logger = Logger.new('/dev/null') unless options['debug']
          x.debug = options['debug']
        end
      end

      def profile
        options['profile'].to_sym
      end

      def self.constant_name
        Kernel.const_get("ATS::#{service_name}::API")
      end

      def self.service_name
        name.split("::")[2]
      end
    end
  end
end
