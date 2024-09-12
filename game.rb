if ARGV.length != 2
  exit
end

player1_choice = ARGV[0].downcase
player2_choice = ARGV[1].downcase

options = ["камінь", "ножиці", "папір"]

unless options.include?(player1_choice) && options.include?(player2_choice)
  puts "неправильно, обери: камінь, ножиці або папір."
  exit
end

puts "1 гравець : #{player1_choice}"
puts "2 гравець: #{player2_choice}"

if player1_choice == player2_choice
  puts "нічия"
elsif (player1_choice == "камінь" && player2_choice == "ножиці") ||
  (player1_choice == "ножиці" && player2_choice == "папір") ||
  (player1_choice == "папір" && player2_choice == "камінь")
  puts "1 гравець переміг"
else
  puts "2 гравець переміг"
end


