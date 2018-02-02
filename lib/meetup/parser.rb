module Meetup
  class Parser
    include Import[:logger]

    def parse(file_path)
      results = []
      index = 1
      # File.foreach is the best way to read files as it's the solution that
      # archives less memory consumption. Basically, the lines are being loaded
      # into memory one by one, which becomes essential when reading larger files.
      #
      # https://felipeelias.github.io/ruby/2017/01/02/fast-file-processing-ruby.html
      File.foreach(file_path) do |line|
        # Empty lines or comments are not processed.
        next if line.empty? || line.match(/^(#|\/\/).*$/)
        person = parse_entry(line, index)
        results << person if person
      ensure
        index = index + 1
      end
      results
    end

    def parse_entry(line, line_number)
      person = Oj.load(line, symbol_keys: true)
      if !person.nil? && !person.values.any?(&:nil?)
        Meetup::Person.new(person)
      else
        logger.warn("Missing data in our customer entry, skipping invitation. (See: L#{line_number})".yellow)
        nil
      end
    rescue Oj::ParseError, Dry::Struct::Error, ArgumentError
      logger.error("Error while parsing customer entry. Omitting. (See: #{line_number})".red)
      nil
    end
  end
end
