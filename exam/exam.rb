class CharFreq
  def initialize(text)
    raise ArgumentError, 'Input must be a valid string.' unless text.is_a?(String)
    raise ArgumentError, 'Input cannot be empty or just whitespace.' if text.strip.empty?

    @text = text
  end

  def self.from_file(file_path)
    raise ArgumentError, 'File path must be a string.' unless file_path.is_a?(String)
    raise ArgumentError, "File not found: #{file_path}" unless File.exist?(file_path)

    text = File.read(file_path).strip
    raise ArgumentError, 'File is empty or contains only whitespace.' if text.empty?

    new(text)
  end

  def calculate_frequency
    frequency = Hash.new(0)
    @text.each_char { |char| frequency[char] += 1 }
    frequency
  end

  def sentences
    @text.scan(/[^.!?]*[.!?]/).map(&:strip)
  end
end

begin
  file_path = 'text.txt'
  cf = CharFreq.from_file(file_path)

  puts "Frequency from file '#{file_path}':"

  # для компактного виводу
  formatted_output = cf.calculate_frequency.map { |char, count| "\"#{char}\" => #{count}" }
                       .each_slice(10)
                       .map { |group| group.join(", ") }
                       .join(",\n")

  puts "{\n#{formatted_output}\n}"
rescue ArgumentError => e
  puts "Error: #{e.message}"
end



