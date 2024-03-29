module ATS
  module CLI
    module AMP4E
      class Events < Command
        desc 'list', 'list'
        def list
          print_json api.events.list
        end

        desc 'types', 'list'
        def types
          print_json api.events.types
        end
      end
    end
  end
end
