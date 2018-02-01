module Meetup
  class Parser
    include Import['logger']

    def call(file_path)
      results = []
      File.foreach(file_path) do |line|
        begin
          person = Oj.parse(line, symbol_keys: true)
          if person.values.any?(&:nil)
            logger.warn("Missing data in our customer entry, skipping invitation. (See: #{line}".yellow)
            next
          else
            results << person
          end
        rescue Oj::ParseError
          logger.error("Error while parsing customer entry. Omitting. (See: #{line}".red)
          next
        end
      end
      results
    end
  end
end
