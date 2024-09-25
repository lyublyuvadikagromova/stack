def to_rpn(expression)
  output = []
  operators = []

  precedence = {
    '+' => 1, '-' => 1,
    '*' => 2, '/' => 2
  }
  expression = expression.gsub('(', ' ( ').gsub(')', ' ) ')

  expression.split.each do |token|
    if token.match?(/\d+/)
      output << token
    elsif ['+', '-', '*', '/'].include?(token)
      while !operators.empty? && precedence[operators.last] && precedence[operators.last] >= precedence[token]
        output << operators.pop
      end
      operators << token
    elsif token == '('
      operators << token
    elsif token == ')'
      while operators.last != '('
        output << operators.pop
      end
      operators.pop
    end
  end
  output.concat(operators.reverse)

  output.join(' ')
end
puts "введіть вираз:"
expression = gets.chomp
puts "зворотний польський запис:"
puts to_rpn(expression)


