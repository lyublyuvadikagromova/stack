def l_y(year)
  (year % 4 == 0 && year % 100 != 0) || year % 400 == 0
end


def test_l_y
  passed = 0
  failed = 0

  if l_y(2000) == true
    puts "test passed for year 2000"
    passed += 1
  else
    puts "test failed for year 2000"
    failed += 1
  end

  if l_y(2024) == true
    puts "test passed for year 2024"
    passed += 1
  else
    puts "test failed for year 2024"
    failed += 1
  end

  if l_y(1600) == true
    puts "test passed for year 1600"
    passed += 1
  else
    puts "test failed for year 1600"
    failed += 1
  end

  if l_y(1900) == false
    puts "test passed for year 1900"
    passed += 1
  else
    puts "test failed for year 1900"
    failed += 1
  end

  if l_y(2021) == false
    puts "test passed for year 2021"
    passed += 1
  else
    puts "test failed for year 2021"
    failed += 1
  end

  if l_y(2100) == false
    puts "test passed for year 2100"
    passed += 1
  else
    puts "test failed for year 2100"
    failed += 1
  end

  invalid_input = "abc"
  if invalid_input.to_i.to_s != invalid_input
    puts "test passed for invalid input (text)"
    passed += 1
  else
    puts "test failed for invalid input (text)"
    failed += 1
  end

  negative_input = "-100"
  if negative_input.to_i <= 0
    puts "test passed for negative input"
    passed += 1
  else
    puts "test failed for negative input"
    failed += 1
  end

  if l_y(1) == false
    puts "test passed for year 1"
    passed += 1
  else
    puts "test failed for year 1"
    failed += 1
  end

  if l_y(9999) == false
    puts "test passed for year 9999"
    passed += 1
  else
    puts "test failed for year 9999"
    failed += 1
  end

  if l_y(123456789) == false
    puts "test passed for year 123456789"
    passed += 1
  else
    puts "test failed for year 123456789"
    failed += 1
  end

  puts "\ntest results:"
  puts "tests passed: #{passed}"
  puts "tests failed: #{failed}"
end

test_l_y
