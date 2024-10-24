def l_y(year)
  (year % 4 == 0 && year % 100 != 0) || year % 400 == 0
end

print "enter a year: "
year = gets.chomp.to_i

if year > 0 && year <= 9999
  message = "#{year} is a leap year." if l_y(year)
  message ||= "#{year} is not a leap year."
else
  message = "invalid input"
end

puts message
