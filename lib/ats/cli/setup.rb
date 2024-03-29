module ATS
  module CLI
    class Setup < Command
      default_command :setup

      desc 'setup', 'Initialize the .atsrc file.'
      def setup
        say "Default Configuration:", :green
        yaml = YAML.dump(default_settings)
        say yaml, :yellow

        say "Current Configuration:", :green
        say JSON.pretty_generate(configuration.to_h), :green

        configuration.config_files.each do |file|
          if File.exist?(file)
            say "Found #{file}. Nothing to do. Good bye!", :green
            exit 0
          end
        end

        say "Configuration file not found."
        new_file = configuration.config_files.first
        say "New file created at #{new_file}."
        IO.write(new_file, yaml)
        File.chmod(0600, new_file)
      end

      private

      def default_settings
        {
          default: {
            amp4e: {
              client_id: '',
              client_secret: '',
              host: 'api.amp.cisco.com',
              port: 443,
              scheme: 'https',
            },
            threatgrid: {
              api_key: '',
              host: 'panacea.threatgrid.com',
              port: 443,
              scheme: 'https',
            },
            shiro: {
              bearer_token: '',
              host: 'auth.amp.cisco.com',
              port: 443,
              scheme: 'https',
            },
          }
        }
      end
    end
  end
end
