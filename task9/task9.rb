puts "введіть назву текстового файлу (.txt):"
file_name = gets.chomp

unless File.exist?(file_name)
  puts "файл '#{file_name}' не знайдено"
  exit
end

begin
  text = File.read(file_name)
rescue Errno::EACCES
  puts "файл не вдається відкрити '#{file_name}' через обмеження доступу"
  exit
end

words = text.downcase.scan(/[a-zа-яіїєґ']+/i)

word_frequency = Hash.new(0)
words.each { |word| word_frequency[word] += 1 }

puts "частота використання слів у файлі '#{file_name}':"
word_frequency.sort_by { |_, count| -count }.each do |word, count|
  puts "#{word}: #{count}"
end
