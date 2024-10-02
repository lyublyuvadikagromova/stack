def to_rpn(expression)
  output = []
  operators = []

  precedence = {
    '+' => 1, '-' => 1,
    '*' => 2, '/' => 2
  }

  expression = expression.gsub('(', ' ( ').gsub(')', ' ) ').gsub(/\s+/, '')

  if expression.match?(/[-+*\/]$/)
    puts "неповний вираз!"
    return
  end

  tokens = expression.scan(/[\d\.]+|[-+*\/()]/)
  tokens.each_with_index do |token, index|
    if token.match?(/[\d\.]+/)
      output << token
    elsif token == '-' && (index == 0 || tokens[index - 1] == '(' || ['+', '-', '*', '/'].include?(tokens[index - 1]))
      output << '-' + tokens[index + 1]
      tokens[index + 1] = ''
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

if expression.include?('/ 0') || expression.include?('/0')
  puts "неможливе ділення на нуль!"
else
  rpn = to_rpn(expression)
  puts "зворотний польський запис:"
  puts rpn
end



